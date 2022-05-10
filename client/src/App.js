import React from 'react'
import { Container } from '@material-ui/core'
import { BrowserRouter, Switch, Route, Redirect } from 'react-router-dom'

import PostDetails from './components/PostDetails/PostDetails'
import Navbar from './components/Navbar/Navbar'
import Home from './components/Home/Home'
import Auth from './components/Auth/Auth'
import CreatorOrTag from './components/CreatorOrTag/CreatorOrTag'

const App = () => {
  const user = JSON.parse(localStorage.getItem('profile'))

  return (
    <BrowserRouter>
      <Container maxWidth="xl">
        <Navbar />
        <Switch>
          <Route path="/" exact component={() => <Redirect to="/citizens" />} />
          <Route path="/citizens" exact component={Home} />
          <Route path="/citizens/search" exact component={Home} />
          <Route path="/citizens/:id" exact component={PostDetails} />
          <Route
            path={['/creators/:name', '/tags/:name']}
            component={CreatorOrTag}
          />
          <Route
            path="/auth"
            exact
            component={() => (!user ? <Auth /> : <Redirect to="/citizens" />)}
          />
        </Switch>
      </Container>
    </BrowserRouter>
  )
}

export default App
