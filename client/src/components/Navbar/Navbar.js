import React, { useState, useEffect } from 'react';
import {
  Button,
  Avatar,
  Container,
  Typography,
  Toolbar,
  AppBar
} from '@material-ui/core';
import { Link, useHistory, useLocation } from 'react-router-dom';
import { useDispatch } from 'react-redux';
import decode from 'jwt-decode';

import logo from '../../images/logo.png'
import * as actionType from '../../constants/actionTypes';
import useStyles from './styles';

const Navbar = () => {
  const [user, setUser] = useState(JSON.parse(localStorage.getItem('profile')));
  const dispatch = useDispatch();
  const location = useLocation();
  const history = useHistory();
  const classes = useStyles();

  const logout = () => {
    dispatch({ type: actionType.LOGOUT });

    history.push('/auth');

    setUser(null);
  };

  useEffect(() => {
    const token = user?.token;

    if (token) {
      const decodedToken = decode(token);

      if (decodedToken.exp * 1000 < new Date().getTime()) logout();
    }

    setUser(JSON.parse(localStorage.getItem('profile')));
  }, [location]);

  return (
    <AppBar
      position="static"
      style={{
        backgroundColor: '#2f3542',
        padding: '10px 0',
        marginBottom: '10px'
      }}
    >
      <Container maxWidth="xl">
        <Toolbar
          disableGutters
          style={{
            justifyContent: 'space-between',
          }}
        >
          <Link to="/">
            <img to="/" component={Link} src={logo} alt="icon" height="50px" />
          </Link>

          {user?.result ? (
            <div className={classes.navlinks}>
              <Link to="/home">
                <Typography className={classes.link}>
                  Home
                </Typography>

              </Link>
              <Link to="/citizens" >
                <Typography className={classes.link}>
                  Citizens
                </Typography>

              </Link>
              <Link to="/companies">
                <Typography className={classes.link}>
                  Companies
                </Typography>

              </Link>

              <Link to="/complains">
                <Typography className={classes.link}>
                  Complains
                </Typography>

              </Link>
              <Avatar
                alt={user?.result.name}
                src={user?.result.profilePic}
                style={{
                  margin: '0 10px',
                }}
              />
              <Typography className={classes.userName}>
                {user?.result.name}
              </Typography>

              <Button
                style={{ marginLeft: '10px' }}
                variant="contained"
                color="primary"
                onClick={logout}
              >
                Logout
              </Button>
            </div>
          ) : (
            <Button
              component={Link}
              to="/auth"
              variant="contained"
              className={classes.logout}
            >
              Sign In
            </Button>
          )}
        </Toolbar>
      </Container>
    </AppBar>
  );
};

export default Navbar;
