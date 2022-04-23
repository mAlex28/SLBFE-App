import React, { useState } from 'react'
import { Box, Tabs, Tab, Grow, Container, Grid } from '@mui/material'
import PropTypes from 'prop-types'
import CitizenTab from './CitizenTab/CitizenTab'

function TabPanel(props) {
  const { children, value, index, ...other } = props

  return (
    <div
      role="tabpanel"
      hidden={value !== index}
      id={`simple-tabpanel-${index}`}
      aria-labelledby={`simple-tab-${index}`}
      {...other}
    >
      {value === index && (
        <Grow in>
          <Container maxWidth="xl">
            <Grid
              container
              justify="space-between"
              alignItems="stretch"
              spacing={3}
            >
              {children}
            </Grid>
          </Container>
        </Grow>
      )}
    </div>
  )
}

TabPanel.propTypes = {
  children: PropTypes.node,
  index: PropTypes.number.isRequired,
  value: PropTypes.number.isRequired,
}

function a11yProps(index) {
  return {
    id: `simple-tab-${index}`,
    'aria-controls': `simple-tabpanel-${index}`,
  }
}

const TabItems = () => {
  const [value, setValue] = useState(0)

  const handleChange = (event, newValue) => {
    setValue(newValue)
  }

  return (
    <>
      <Box sx={{ borderBottom: 1, borderColor: 'divider' }}>
        <Tabs value={value} onChange={handleChange} aria-label="user tabs">
          <Tab label="Job Seekers" {...a11yProps(0)} />
          <Tab label="Foreign companies" {...a11yProps(1)} />
        </Tabs>
      </Box>
      <TabPanel value={value} index={0}>
        <CitizenTab />
      </TabPanel>
      <TabPanel value={value} index={1}>
        Item Two
      </TabPanel>
    </>
  )
}

export default TabItems
