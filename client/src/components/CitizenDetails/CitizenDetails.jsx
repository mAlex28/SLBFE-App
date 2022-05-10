import React, { useEffect } from 'react';
import { Paper, Typography, CircularProgress, Button, Avatar, Divider, Card, CardContent, CardHeader, CardActions, IconButton, List, ListItemText, ListItem, ListItemIcon, Icon } from '@material-ui/core/';
import { useDispatch, useSelector } from 'react-redux';
import FiberManualRecordIcon from '@material-ui/icons/FiberManualRecord';
import DoneIcon from '@material-ui/icons/Done';
import PhoneInTalkIcon from '@material-ui/icons/PhoneInTalk';
import EmailIcon from '@material-ui/icons/Email';
import DeleteIcon from '@material-ui/icons/Delete';
import CloseIcon from '@material-ui/icons/Close';
import LocationOnIcon from '@material-ui/icons/LocationOn';
import moment from 'moment';
import { useParams, useHistory, Link } from 'react-router-dom';
import { triggerBase64Download } from 'react-base64-downloader';

import { deleteCitizen, getCitizen, updateCitizen } from '../../actions/citizens';
import useStyles from './styles';

const Post = () => {
  const { citizen, citizens, isLoading } = useSelector((state) => state.citizens);
  const dispatch = useDispatch();
  const history = useHistory();
  const classes = useStyles();
  const { id } = useParams();

  useEffect(() => {
    dispatch(getCitizen(id));
  }, [id]);

  const handleDelete = () => {
    dispatch(deleteCitizen(citizen._id))
    history.push('/citizens')
  }

   const showInMapClicked = () => {
    window.open("https://maps.google.com?q="+citizen.location.latitude+","+citizen.location.longitude );
  };

  if (!citizen) return null;

  if (isLoading) {
    return (
      <Paper elevation={6} className={classes.loadingPaper}>
        <CircularProgress size="7em" />
      </Paper>
    );
  }

  return (
    <Card style={{ padding: '20px', borderRadius: '15px' }} elevation={6}>
      <CardHeader
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
              onClick={() => dispatch(updateCitizen(citizen._id, { isVerified: false }))}
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
              onClick={() => dispatch(updateCitizen(citizen._id, { isVerified: true }))}
              variant="outlined"
              startIcon={
                <CloseIcon />
              }
            >
              Not Verified
            </Button>
          )
        }
        title={<Typography variant="h5" component="h5">{citizen.name}</Typography>}
        subheader={<Typography gutterBottom variant="h6" color="textSecondary" style={{
          fontSize: '16px'
        }}>{citizen.profession.toUpperCase()} </Typography>}
      />
      <CardContent>
        <div className={classes.card}>
        <div className={classes.section}>
         
        <Typography variant="body2" color="textPrimary" style={{
          fontSize: '18px'
        }}>
          {citizen.description}
        </Typography>
         <Typography variant="body2" color="textPrimary" style={{
           margin: '10px 10px',
          fontSize: '20px'
        }}>
          <b>Qualifications</b>
        </Typography>

       <List dense>
              {citizen.qualifications.map((tag) => (
                <ListItem>
                  <ListItemIcon>
                    <FiberManualRecordIcon fontSize='small' />
                  </ListItemIcon>
                  <ListItemText
                   
                    primary={tag}
                  />
                </ListItem>
              ))}
            </List>
          <Typography gutterBottom variant="h6" color="textSecondary"  style={{
           margin: '10px 10px',
          fontSize: '20px'
        }}>  <b>NIC</b>: {citizen.nic}
          </Typography>
             <Typography gutterBottom variant="h6" color="textSecondary"  style={{
           margin: '10px 10px',
          fontSize: '20px'
        }}>  <b>Age</b>: {citizen.age}
          </Typography>
             <Typography gutterBottom variant="h6" color="textSecondary"  style={{
           margin: '10px 10px',
          fontSize: '20px'
        }}>  <b>Address</b>: {citizen.address + ", " + citizen.city + ", " + citizen.province + ", Sri Lanka (" + citizen.postalCode + ")" }
          </Typography>
            <Typography gutterBottom variant="h6" color="textSecondary"  style={{
           margin: '10px 10px',
          fontSize: '20px'
        }}>  <b>Location</b>: {citizen.location.latitude + ", " + citizen.location.longitude }  <Button onClick={showInMapClicked} color="primary" startIcon={<LocationOnIcon />}>View in map</Button>
          </Typography>

          <Divider style={{ margin: '20px 0' }} />
            <Button
             onClick={() => {
               citizen.cv == null || citizen.cv == "" ? alert('CV not available'): triggerBase64Download(citizen.cv, `citizen_${citizen.nic}_cv`)
             }}
             style={{
              margin: '10px'
             }}
        variant="contained"
        color="default"

      >
        Download CV
      </Button>
<Button
                onClick={() => {
               citizen.cv == null || citizen.cv == "" ? alert('Birth Certificate not available'): triggerBase64Download(citizen.birthCertificate, `citizen_${citizen.nic}_birthcertificate`)
             }}
             style={{
               margin: '10px'
             }}
        variant="contained"
        color="default"
      >
        Download Birth Certificate
      </Button>
      <Button
                 onClick={() => {
               citizen.cv == null || citizen.cv == "" ? alert('Passport photo not available'): triggerBase64Download(citizen.passport, `citizen_${citizen.nic}_passport`)
             }}
             style={{
               margin: '10px'
             }}
        variant="contained"
        color="default"
      >
        Download Passport
      </Button>
          <Divider style={{ margin: '20px 0' }} />
        
         <CardActions disableSpacing style={{
           display: 'flex',
           flexDirection: 'row',
           alignContent: 'center',
           justifyContent: 'space-between'
         }}>
        <div>
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
        </div>
         <div>
            <Typography variant="body2">Joined {moment(citizen.createdAt).fromNow()}</Typography>
             <Button
             onClick={handleDelete}
             style={{
               marginTop: '10px'
             }}
        variant="contained"
        color="secondary"
        startIcon={<DeleteIcon />}
      >
        Delete Citizen
      </Button>
         </div>
      </CardActions>
        </div>
       
      </div>
      </CardContent>
    </Card>
  );
};

export default Post;
