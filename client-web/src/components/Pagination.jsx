/* eslint-disable react/jsx-props-no-spreading */
import React, { useEffect } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { Pagination, PaginationItem } from '@mui/material'
import { Link } from 'react-router-dom'
import { getAllCitizens } from '../actions/citizens'

const Paginate = ({ page }) => {
  const { numberOfPages } = useSelector((state) => state.citizens)
  const dispatch = useDispatch()

  console.log(numberOfPages)

  useEffect(() => {
    if (page) {
      dispatch(getAllCitizens(page))
    }
  }, [dispatch, page])

  return (
    <Pagination
      count={numberOfPages}
      page={Number(page) || 1}
      variant="outlined"
      color="primary"
      renderItem={(item) => (
        <PaginationItem
          {...item}
          component={Link}
          to={`/citizen?page=${item.page}`}
        />
      )}
    />
  )
}

export default Paginate
