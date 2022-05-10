import React, { useEffect } from 'react';
import { Paper, Typography, CircularProgress, Divider } from '@material-ui/core/';
import { useDispatch, useSelector } from 'react-redux';
import moment from 'moment';
import { useParams, useHistory, Link } from 'react-router-dom';

import { getCitizen, getCitizensBySearch } from '../../actions/citizens';
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

  useEffect(() => {
    if (citizen) {
      dispatch(getCitizensBySearch({ search: 'none', tags: citizen?.tags.join(',') }));
    }
  }, [citizen]);

  if (!citizen) return null;

  if (isLoading) {
    return (
      <Paper elevation={6} className={classes.loadingPaper}>
        <CircularProgress size="7em" />
      </Paper>
    );
  }

  return (
    <Paper style={{ padding: '20px', borderRadius: '15px' }} elevation={6}>
      loading
      {/* <div className={classes.card}>
        <div className={classes.section}>
          <Typography variant="h3" component="h2">{citizen.title}</Typography>
          <Typography gutterBottom variant="h6" color="textSecondary" component="h2">{citizen.tags.map((tag) => (
            <Link to={`/tags/${tag}`} style={{ textDecoration: 'none', color: '#3f51b5' }}>
              {` #${tag} `}
            </Link>
          ))}
          </Typography>
          <Typography gutterBottom variant="body1" component="p">{citizen.message}</Typography>
          <Typography variant="h6">
            Created by:
            <Link to={`/creators/${citizen.name}`} style={{ textDecoration: 'none', color: '#3f51b5' }}>
              {` ${citizen.name}`}
            </Link>
          </Typography>
          <Typography variant="body1">{moment(citizen.createdAt).fromNow()}</Typography>
          <Divider style={{ margin: '20px 0' }} />
          <Typography variant="body1"><strong>Realtime Chat - coming soon!</strong></Typography>
          <Divider style={{ margin: '20px 0' }} />
        </div>
        <div className={classes.imageSection}>
          <img className={classes.media} src={post.selectedFile || 'https://user-images.githubusercontent.com/194400/49531010-48dad180-f8b1-11e8-8d89-1e61320e1d82.png'} alt={post.title} />
        </div>
      </div> */}
    </Paper>
  );
};

export default Post;
