/* eslint-disable react/jsx-props-no-spreading */
import React, { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Pagination, PaginationItem } from '@material-ui/lab';
import { Link } from 'react-router-dom';

import { getComplains } from '../actions/complains'
import useStyles from './styles';

const ComplainPaginate = ({ page }) => {
  const { numberOfPages } = useSelector((state) => state.complains);
  const dispatch = useDispatch();

  const classes = useStyles();

  useEffect(() => {
    if (page) {
      console.log(page)
      dispatch(getComplains(page));
    }
  }, [dispatch, page]);

  return (
    <Pagination
      classes={{ ul: classes.ul }}
      count={numberOfPages}
      page={Number(page) || 1}
      variant="outlined"
      color="primary"
      renderItem={(item) => (
        <PaginationItem {...item} component={Link} to={`/complains?page=${item.page}`} />
      )}
    />
  );
};

export default ComplainPaginate;
