import { CircularProgress, Grid } from '@mui/material'
import React from 'react'
import { useSelector } from 'react-redux'
import CitizenCard from './CitizenCard'

const CitizenCards = () => {
  const { citizens, isLoading } = useSelector((state) => state.citizens)
  if (!citizens.length && !isLoading) return 'No users found'

  return isLoading ? (
    <CircularProgress />
  ) : (
    <Grid>
      {citizens?.map((citizen) => (
        <Grid key={citizen._id} item xs={12} sm={12} md={12} lg={12}>
          <CitizenCard citizen={citizen} />
        </Grid>
      ))}
    </Grid>
  )
}

export default CitizenCards
