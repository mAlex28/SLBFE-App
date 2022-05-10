import React, { useEffect } from 'react';
import { Paper, Typography, CircularProgress, Button, Avatar, Divider, Card, CardContent, CardHeader, CardActions, IconButton, List, ListItemText, ListItem, ListItemIcon } from '@material-ui/core/';
import { useDispatch, useSelector } from 'react-redux';
import FiberManualRecordIcon from '@material-ui/icons/FiberManualRecord';
import PhoneInTalkIcon from '@material-ui/icons/PhoneInTalk';
import EmailIcon from '@material-ui/icons/Email';
import DeleteIcon from '@material-ui/icons/Delete';
import moment from 'moment';
import { useParams, useHistory, Link } from 'react-router-dom';

import { deleteCompany, getCompany } from '../../actions/companies';
import useStyles from './styles';

const CompanyDetails = () => {
  const { company, companies, isLoading } = useSelector((state) => state.companies);
  const dispatch = useDispatch();
  const history = useHistory();
  const classes = useStyles();
  const { id } = useParams();

  useEffect(() => {
    dispatch(getCompany(id));
  }, [id]);

  const handleDelete = () => {
    dispatch(deleteCompany(company._id))
    history.push('/companies')
  }

  if (!company) return null;

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
          
            <Avatar style={{ backgroundColor: '#34495e' }} aria-label="avatar">
              {company.companyName.charAt(0)}
            </Avatar>
        }
        action={
            <Button
              onClick={handleDelete}
              className={classes.deleteButton}
              variant="outlined"
              startIcon={
                <DeleteIcon />
              }
            >
              Delete
            </Button>
         
        }
        title={<Typography variant="h5" component="h5">{company.companyName}</Typography>}
        subheader={<Typography gutterBottom variant="h6" color="textSecondary" style={{
          fontSize: '16px'
        }}>{company.country.toUpperCase()} </Typography>}
      />
      <CardContent>
        <div className={classes.card}>
        <div className={classes.section}>
         
        <Typography variant="body2" color="textPrimary" style={{
          fontSize: '18px'
        }}>
          {company.description}
        </Typography>
         <Typography variant="body2" color="textPrimary" style={{
           margin: '10px 10px',
          fontSize: '20px'
        }}>
          <b>Hiring Fields</b>
        </Typography>

       <List dense>
              {company.companyFields.map((tag) => (
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
          fontSize: '18px'
        }}>  <b>Contact</b>: {company.contact}
          </Typography>
             <Typography gutterBottom variant="h6" color="textSecondary"  style={{
           margin: '10px 10px',
          fontSize: '18px'
        }}>  <b>Email</b>: {company.email}
          </Typography>
             <Typography gutterBottom variant="h6" color="textSecondary"  style={{
           margin: '10px 10px',
          fontSize: '18px'
        }}>  <b>Address</b>: {company.address + ", " + company.city + ", " + company.province + ", " + company.country }
          </Typography>
             <Typography gutterBottom variant="h6" color="textSecondary" style={{
           margin: '10px 10px',
          fontSize: '18px'
        }}>  <b>Website</b>:  {company.website == null || company.website == ""  ? 'Not available' : <Link
          to="#"
          onClick={() => (window.open(`${company.website}`,'_blank'))}
        >
          {company.website}
        </Link>}
          </Typography>
          <Divider style={{ margin: '18px 0' }} />
        
         <CardActions disableSpacing style={{
           display: 'flex',
           flexDirection: 'row',
           alignContent: 'center',
           justifyContent: 'space-between'
         }}>
        <div>
          <Link
          to="#"
          onClick={() => (window.location.href = `tel:${company.contact}`)}
        >
          <IconButton aria-label="call" color="primary">
            <PhoneInTalkIcon />
          </IconButton>
        </Link>
        <Link
          to="#"
          onClick={() => (window.location.href = `mailto:${company.email}`)}
        >
          <IconButton aria-label="email" color="primary">
            <EmailIcon />
          </IconButton>
        </Link>
        </div>
         <div>
            <Typography variant="body2">Joined {moment(company.createdAt).fromNow()}</Typography>
         </div>
      </CardActions>
        </div>
       
      </div>
      </CardContent>
    </Card>
  );
};

export default CompanyDetails;
