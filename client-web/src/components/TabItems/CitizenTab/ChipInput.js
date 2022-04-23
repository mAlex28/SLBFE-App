import { Autocomplete, TextField, Chip } from '@mui/material'
import React, { useEffect, useState } from 'react'

export default function ChipInput() {
  const [receivers, setReceivers] = useState([])
  console.log(receivers)
  return (
    <Autocomplete
      multiple
      id="tags-filled"
      options={[]}
      defaultValue={[]}
      freeSolo
      onChange={(e, value) => setReceivers([...receivers, value])}
      renderTags={(value, getTagProps) =>
        value.map((option, index) => (
          <Chip variant="outlined" label={option} {...getTagProps({ index })} />
        ))
      }
      renderInput={(params) => (
        <TextField
          {...params}
          variant="filled"
          label="freeSolo"
          placeholder="Favorites"
        />
      )}
    />
  )
}
