import React from 'react';
import { Grid, CircularProgress } from '@material-ui/core';
import { useSelector } from 'react-redux';

import useStyles from './styles';
import Complain from './Complain/Complain';

const Complains = () => {
    const { complains, isLoading } = useSelector((state) => state.complains);
    const classes = useStyles();

    if (!complains.length && !isLoading) return 'No complains';

    return (
        isLoading ? <CircularProgress /> : (
            <Grid className={classes.container} container alignItems="stretch" spacing={3}>
                {complains?.map((complain) => (
                    <Grid key={complain._id} item xs={12} sm={12} md={12} lg={12}>
                        <Complain complain={complain} />
                    </Grid>
                ))}
            </Grid>
        )
    );
};

export default Complains;
