import React from 'react';
import { Container, Grow, Grid, Paper } from '@material-ui/core';
import { useLocation } from 'react-router-dom';

import Complains from '../Complains/Complains';
import Pagination from '../ComplainPagination';
import useStyles from './styles';

function useQuery() {
    return new URLSearchParams(useLocation().search);
}
const ComplainHome = () => {
    const classes = useStyles();
    const query = useQuery();
    const page = query.get('page') || 1;

    return (
        <Grow in>
            <Container maxWidth="xl">
                <Grid container justifyContent="space-between" alignItems="stretch" spacing={3} className={classes.gridContainer}>
                    <Grid item xs={12} sm={6} md={9}>
                        <Complains />
                    </Grid>
                    <Grid item xs={12} sm={6} md={3}>
                        <Paper className={classes.pagination} elevation={6}>
                            <Pagination page={page} />
                        </Paper>
                    </Grid>
                </Grid>
            </Container>
        </Grow>
    );
};

export default ComplainHome;
