import React, { useState } from 'react';
import { Card, CardActions, CardContent, CardMedia, Button, Typography, ButtonBase, CardHeader, Avatar, IconButton } from '@material-ui/core/';
import DeleteIcon from '@material-ui/icons/Delete';
import DoneIcon from '@material-ui/icons/Done'
import PhoneInTalkIcon from '@material-ui/icons/PhoneInTalk'
import EmailIcon from '@material-ui/icons/Email'
import CloseIcon from '@material-ui/icons/Close'
import { useDispatch } from 'react-redux';
import { useHistory, Link} from 'react-router-dom';

import { likePost, deletePost } from '../../../actions/posts';
import useStyles from './styles';

const Post = ({ citizen, setCurrentId }) => {
  const user = JSON.parse(localStorage.getItem('profile'));
  const dispatch = useDispatch();
  const history = useHistory();
  const classes = useStyles();

  const userId = user?.result?._id;

  const viewCitizen = (e) => {
    // dispatch(getPost(post._id, history));

    history.push(`/citizens/${citizen._id}`);
  };

  return (
   <Card
      elevation={5}
      sx={{
        width: '80%',
        padding: '10px',
        marginTop: '20px',
        marginBottom: '10px',
      }}
    >
      <CardHeader
        onClick={viewCitizen}
        avatar={
          citizen.profilePic ? (
            <Avatar
              alt={citizen.name}
              src={citizen.profilePic}
              aria-label="avatar"
            />
          ) : (
            <Avatar sx={{ bgcolor: 'red' }} aria-label="avatar">
              {citizen.name.charAt(0)}
            </Avatar>
          )
        }
        action={
          citizen.isVerified ? (
            <Button
              variant="outlined"
              color="success"
              startIcon={
                <DoneIcon
                  sx={{
                    color: '#4caf50',
                  }}
                />
              }
            >
              Verified
            </Button>
          ) : (
            <Button
              variant="outlined"
              color="warning"
              startIcon={
                <CloseIcon
                  sx={{
                    color: '#4caf50',
                  }}
                />
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
        <Typography variant="body2" color="text.secondary">
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
        <Typography variant="body2" color="GrayText" component="p">
          {citizen.qualifications.map((qualification) => `#${qualification} `)}
        </Typography>
      </div>
      <CardActions disableSpacing>
        <Link
          to="#"
          onClick={() => (window.location.href = `tel:${citizen.contact}`)}
        >
          <IconButton aria-label="call">
            <PhoneInTalkIcon />
          </IconButton>
        </Link>
        <Link
          to="#"
          onClick={() => (window.location.href = `mailto:${citizen.email}`)}
        >
          <IconButton aria-label="email">
            <EmailIcon />
          </IconButton>
        </Link>
      </CardActions>
    </Card>
  );
};

export default Post;

