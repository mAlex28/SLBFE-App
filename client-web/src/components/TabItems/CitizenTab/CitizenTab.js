import React, { useState } from 'react'
import {
  AppBar,
  TextField,
  Button,
  Grid,
  Autocomplete,
  Chip,
} from '@mui/material'

import CitizenCard from './CitizenCard'

const CitizenTab = () => {
  const [qualifications, setQualifications] = useState([])
  const [search, setSearch] = useState('')

  const searchPost = () => {
    if (search.trim() || qualifications) {
      console.log(qualifications)
    } else {
      console.log('error')
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
        <CitizenCard />
        <CitizenCard />
        <CitizenCard />
        <CitizenCard />
        <CitizenCard />
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
      </Grid>
    </>
  )
}

export default CitizenTab
