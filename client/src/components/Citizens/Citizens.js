import React from 'react';
import { Grid, CircularProgress } from '@material-ui/core';
import { useSelector } from 'react-redux';

import useStyles from './styles';
import Citizen from './Citizen/Citizen';

const Citizens = ({ setCurrentId }) => {
  const { citizens, isLoading } = useSelector((state) => state.citizens);
  const classes = useStyles();

  if (!citizens.length && !isLoading) return 'No citizens';

  return (
    isLoading ? <CircularProgress /> : (
      <Grid className={classes.container} container alignItems="stretch" spacing={3}>
        {citizens?.map((post) => (
          <Grid key={post._id} item xs={12} sm={12} md={12} lg={12}>
            <Citizen citizen={post} setCurrentId={setCurrentId} />
          </Grid>
        ))}
      </Grid>
    )
  );
};

export default Citizens;
