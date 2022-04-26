import React, { useState } from 'react'
import {
  AppBar,
  TextField,
  Button,
  Grid,
  Autocomplete,
  Chip,
  Paper,
} from '@mui/material'
import { useNavigate, useLocation } from 'react-router-dom'
import { useDispatch } from 'react-redux'

import { getCitizensBySearch } from '../../../actions/citizens'
import CitizenCards from './CitizenCards'
import Pagination from '../../Pagination'

function useQuery() {
  return new URLSearchParams(useLocation().search)
}

const CitizenTab = () => {
  const query = useQuery()
  const [search, setSearch] = useState('')
  const [qualifications, setQualifications] = useState([])
  const page = query.get('page') || 1
  const searchQuery = query.get('searchQuery')
  const dispatch = useDispatch()
  const navigate = useNavigate()

  const searchPost = () => {
    if (search.trim() || qualifications) {
      dispatch(
        getCitizensBySearch({
          search,
          qualifications: qualifications.join(','),
        })
      )
      navigate(
        `/citizen/search?searchQuery=${
          search || 'none'
        }&qualifications=${qualifications.join(',')}`
      )
    } else {
      navigate('/')
    }
  }

  const handleKeyPress = (e) => {
    if (e.keyCode === 13) {
      searchPost()
    }
  }

  const handleDeleteChip = (qualification) =>
    setQualifications(qualifications.filter((quali) => quali !== qualification))

  return (
    <>
      <Grid item xs={12} sm={6} md={9}>
        <CitizenCards />
      </Grid>
      <Grid item xs={12} sm={6} md={3}>
        <AppBar
          position="static"
          color="inherit"
          sx={{
            marginTop: '20px',
            borderRadius: 4,
            marginBottom: '1rem',
            display: 'flex',
            padding: '16px',
          }}
        >
          <TextField
            onKeyDown={handleKeyPress}
            name="search"
            variant="outlined"
            label="Search Citizens"
            placeholder="Citizen"
            fullWidth
            value={search}
            onChange={(e) => setSearch(e.target.value)}
          />
          <Autocomplete
            multiple
            id="tags-filled"
            options={[]}
            defaultValue={[]}
            freeSolo
            onChange={(e, value) => setQualifications(value)}
            renderTags={(value, getTagProps) =>
              value.map((option, index) => (
                <Chip
                  key={index}
                  variant="outlined"
                  onDelete={(chip) => handleDeleteChip(chip)}
                  label={option}
                  {...getTagProps({ index })}
                />
              ))
            }
            renderInput={(params) => (
              <TextField
                {...params}
                variant="outlined"
                label="Search by Qualifications"
                placeholder="Qualifications"
                helperText="Add qualifications by pressing enter after writing the qualification"
              />
            )}
          />
          <Button
            onClick={searchPost}
            variant="contained"
            color="primary"
            sx={{ marginTop: '15px' }}
          >
            Search
          </Button>
        </AppBar>
        {!searchQuery && qualifications.length && (
          <Paper
            sx={{
              borderRadius: 4,
              marginTop: '1rem',
              padding: '16px',
            }}
            elevation={6}
          >
            <Pagination page={page} />
          </Paper>
        )}
      </Grid>
    </>
  )
}

export default CitizenTab
