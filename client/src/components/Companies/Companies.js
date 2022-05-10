import React from 'react';
import { Grid, CircularProgress } from '@material-ui/core';
import { useSelector } from 'react-redux';

import useStyles from './styles';
import Company from './Company/Company';

const Companies = ({ setCurrentId }) => {
    const { companies, isLoading } = useSelector((state) => state.companies);
    const classes = useStyles();

    if (!companies.length && !isLoading) return 'No companies';

    return (
        isLoading ? <CircularProgress /> : (
            <Grid className={classes.container} container alignItems="stretch" spacing={3}>
                {companies?.map((company) => (
                    <Grid key={company._id} item xs={12} sm={12} md={12} lg={12}>
                        <Company company={company} />
                    </Grid>
                ))}
            </Grid>
        )
    );
};

export default Companies;
