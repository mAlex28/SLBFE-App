import React, { useEffect } from 'react';
import { useParams, useLocation } from 'react-router-dom';
import { Typography, CircularProgress, Grid, Divider } from '@material-ui/core';
import { useDispatch, useSelector } from 'react-redux';

import Citizen from '../Citizens/Citizen/Citizen';
import { getCitizensByName, getCitizensBySearch } from '../../actions/citizens';

const CreatorOrTag = () => {
  const { name } = useParams();
  const dispatch = useDispatch();
  const { citizens, isLoading } = useSelector((state) => state.citizens);

  const location = useLocation();

  useEffect(() => {
    if (location.pathname.startsWith('/tags')) {
      dispatch(getCitizensBySearch({ tags: name }));
    } else {
      dispatch(getCitizensByName(name));
    }
  }, []);

  if (!citizens.length && !isLoading) return 'No citizens';

  return (
    <div>
      <Typography variant="h2">{name}</Typography>
      <Divider style={{ margin: '20px 0 50px 0' }} />
      {isLoading ? <CircularProgress /> : (
        <Grid container alignItems="stretch" spacing={3}>
          {citizens?.map((post) => (
            <Grid key={post._id} item xs={12} sm={12} md={6} lg={3}>
              <Citizen post={post} />
            </Grid>
          ))}
        </Grid>
      )}
    </div>
  );
};

export default CreatorOrTag;
