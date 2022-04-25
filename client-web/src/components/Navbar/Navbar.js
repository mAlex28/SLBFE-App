import React, { useState, useEffect } from 'react'
import { useDispatch } from 'react-redux'
// import decode from 'jwt-decode'
import { Link, useNavigate, useLocation } from 'react-router-dom'

import {
  Button,
  MenuItem,
  Tooltip,
  Avatar,
  Container,
  Menu,
  Typography,
  IconButton,
  Toolbar,
  Box,
  AppBar,
} from '@mui/material'

import logo from '../../images/logo.png'
import * as actionType from '../../constants/actionTypes'

const settings = ['Profile', 'Complain', 'Logout']

const Navbar = () => {
  const [user, setUser] = useState(JSON.parse(localStorage.getItem('profile')))
  const dispatch = useDispatch()
  const location = useLocation()
  const navigate = useNavigate()

  const [anchorElUser, setAnchorElUser] = useState(null)

  const logout = () => {
    dispatch({ type: actionType.LOGOUT_CITIZEN })
    navigate.push('/auth')
    setUser(null)
  }

  const handleOpenUserMenu = (event) => {
    setAnchorElUser(event.currentTarget)
  }

  const handleCloseUserMenu = () => {
    setAnchorElUser(null)
  }
  return (
    <AppBar
      position="static"
      sx={{
        backgroundColor: '#2f3542',
        padding: '10px 0',
      }}
    >
      <Container maxWidth="xl">
        <Toolbar
          disableGutters
          sx={{
            justifyContent: 'space-between',
          }}
        >
          <Link to="/">
            <img to="/" component={Link} src={logo} alt="icon" height="50px" />
          </Link>

          <Box sx={{ flexGrow: 0 }}>
            {user?.result ? (
              <div>
                <Tooltip title="Open settings">
                  <IconButton onClick={handleOpenUserMenu} sx={{ p: 0 }}>
                    <Avatar
                      alt="Remy Sharp"
                      src="/static/images/avatar/2.jpg"
                    />
                  </IconButton>
                </Tooltip>
                <Menu
                  sx={{ mt: '45px' }}
                  id="menu-appbar"
                  anchorEl={anchorElUser}
                  anchorOrigin={{
                    vertical: 'top',
                    horizontal: 'right',
                  }}
                  keepMounted
                  transformOrigin={{
                    vertical: 'top',
                    horizontal: 'right',
                  }}
                  open={Boolean(anchorElUser)}
                  onClose={handleCloseUserMenu}
                >
                  {settings.map((setting) => (
                    <MenuItem key={setting} onClick={handleCloseUserMenu}>
                      <Typography textAlign="center">{setting}</Typography>
                    </MenuItem>
                  ))}
                </Menu>
                <Button variant="contained" color="secondary" onClick={logout}>
                  Logout
                </Button>
              </div>
            ) : (
              <Button
                component={Link}
                to="/auth"
                variant="contained"
                color="primary"
              >
                Sign In
              </Button>
            )}
          </Box>
        </Toolbar>
      </Container>
    </AppBar>
  )
}

export default Navbar
