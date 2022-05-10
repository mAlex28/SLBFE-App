import React, { useState } from 'react';
import { Container, Grow, Grid, AppBar, TextField, Button, Paper } from '@material-ui/core';
import { useDispatch } from 'react-redux';
import { useHistory, useLocation } from 'react-router-dom';
import ChipInput from 'material-ui-chip-input';

import { getCompanyBySearch } from '../../actions/companies';
import Companies from '../Companies/Companies';
import Pagination from '../CompanyPagination';
import useStyles from './styles';

function useQuery() {
    return new URLSearchParams(useLocation().search);
}
const CompanyHome = () => {
    const classes = useStyles();
    const query = useQuery();
    const page = query.get('page') || 1;
    const searchQuery = query.get('searchQuery');

    const [currentId, setCurrentId] = useState(0);
    const dispatch = useDispatch();

    const [search, setSearch] = useState('');
    const [tags, setTags] = useState([]);
    const history = useHistory();

    const searchCompany = () => {
        if (search.trim() || tags) {
            dispatch(getCompanyBySearch({ search, tags: tags.join(',') }));
            history.push(`/companies/search?searchQuery=${search || 'none'}&companyFields=${tags.join(',')}`);
        } else {
            history.push('/');
        }
    };

    const handleKeyPress = (e) => {
        if (e.keyCode === 13) {
            searchCompany();
        }
    };

    const handleAddChip = (tag) => setTags([...tags, tag]);

    const handleDeleteChip = (chipToDelete) => setTags(tags.filter((tag) => tag !== chipToDelete));

    return (
        <Grow in>
            <Container maxWidth="xl">
                <Grid container justifyContent="space-between" alignItems="stretch" spacing={3} className={classes.gridContainer}>
                    <Grid item xs={12} sm={6} md={9}>
                        <Companies setCurrentId={setCurrentId} />
                    </Grid>
                    <Grid item xs={12} sm={6} md={3}>
                        <AppBar className={classes.appBarSearch} position="static" color="inherit">
                            <TextField onKeyDown={handleKeyPress} name="search" variant="outlined" label="Search by Name" fullWidth value={search} onChange={(e) => setSearch(e.target.value)} />
                            <ChipInput
                                style={{ margin: '10px 0' }}
                                value={tags}
                                onAdd={(chip) => handleAddChip(chip)}
                                onDelete={(chip) => handleDeleteChip(chip)}
                                label="Search fields by Tags"
                                variant="outlined"
                            />
                            <Button onClick={searchCompany} className={classes.searchButton} variant="contained" color="primary">Search</Button>
                        </AppBar>
                        {(!searchQuery && !tags.length) && (
                            <Paper className={classes.pagination} elevation={6}>
                                <Pagination page={page} />
                            </Paper>
                        )}
                    </Grid>
                </Grid>
            </Container>
        </Grow>
    );
};

export default CompanyHome;
