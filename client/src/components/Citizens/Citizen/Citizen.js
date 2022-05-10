import React, { useState } from 'react';
import { Card, CardActions, CardContent, Button, Typography, CardHeader, Avatar, IconButton } from '@material-ui/core/';
import DeleteIcon from '@material-ui/icons/Delete';
import DoneIcon from '@material-ui/icons/Done'
import PhoneInTalkIcon from '@material-ui/icons/PhoneInTalk'
import EmailIcon from '@material-ui/icons/Email'
import CloseIcon from '@material-ui/icons/Close'
import { useHistory, Link} from 'react-router-dom';

import { likePost, deletePost } from '../../../actions/posts';
import useStyles from './styles';

const Citizen = ({ citizen }) => {
  const history = useHistory();
  const classes = useStyles();

  const viewCitizen = (e) => {
    history.push(`/citizens/${citizen._id}`);
  };

  return (
   <Card
      elevation={5}
      style={{
        padding: '10px',
        marginTop: '10px',
        marginBottom: '10px',
      }}
    >
      <CardHeader
        style={{
          cursor:'pointer'
        }}
        onClick={viewCitizen}
        avatar={
          citizen.profilePic ? (
            <Avatar
              alt={citizen.name}
              src={citizen.profilePic}
              aria-label="avatar"
            />
          ) : (
            <Avatar style={{ backgroundColor: '#34495e' }} aria-label="avatar">
              {citizen.name.charAt(0)}
            </Avatar>
          )
        }
        action={
          citizen.isVerified ? (
            <Button
              className={classes.verifyButton}
              variant="outlined"
              startIcon={
                <DoneIcon />
              }
            >
              Verified
            </Button>
          ) : (
            <Button
              className={classes.notVerifiedButton}
              variant="outlined"
              startIcon={
                <CloseIcon />
              }
            >
              Not Verified
            </Button>
          )
        }
        title={citizen.name}
        subheader={citizen.profession}
      />
      <CardContent>
        <Typography variant="body2" color="textPrimary">
          {citizen.description.split(' ').splice(0, 50).join(' ')}...
        </Typography>
      </CardContent>
      <div
        style={{
          display: 'flex',
          justifyContent: 'space-between',
          margin: '20px',
        }}
      >
        <Typography variant="body2" color="textSecondary" component="p">
          {citizen.qualifications.map((qualification) => `#${qualification} `)}
        </Typography>
      </div>
      {/* </ButtonBase> */}
      <CardActions disableSpacing>
        <Link
          to="#"
          onClick={() => (window.location.href = `tel:${citizen.contact}`)}
        >
          <IconButton aria-label="call" color="primary">
            <PhoneInTalkIcon />
          </IconButton>
        </Link>
        <Link
          to="#"
          onClick={() => (window.location.href = `mailto:${citizen.email}`)}
        >
          <IconButton aria-label="email" color="primary">
            <EmailIcon />
          </IconButton>
        </Link>
      </CardActions>
    </Card>
  );
};

export default Citizen;

