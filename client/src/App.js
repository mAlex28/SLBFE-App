import React from 'react'
import { BrowserRouter, Switch, Route, Redirect } from 'react-router-dom'

import CitizenDetails from './components/CitizenDetails/CitizenDetails'
import CompanyDetails from './components/CompanyDetails/CompanyDetails'
import Navbar from './components/Navbar/Navbar'
import Home from './components/Home/Home'
import CompanyHome from './components/CompanyHome/CompanyHome'
import ComplainHome from './components/ComplainHome/ComplainHome'
import Auth from './components/Auth/Auth'
import CreatorOrTag from './components/CreatorOrTag/CreatorOrTag'

const App = () => {
  const user = JSON.parse(localStorage.getItem('profile'))

  return (
    <BrowserRouter>
      <Navbar />
      <Switch>
        <Route path="/" exact component={() => <Redirect to="/citizens" />} />
        <Route path="/citizens" exact component={Home} />
        <Route path="/citizens/search" exact component={Home} />
        <Route path="/citizens/:id" exact component={CitizenDetails} />
        <Route path="/companies" exact component={CompanyHome} />
        <Route path="/companies/search" exact component={CompanyHome} />
        <Route path="/companies/:id" exact component={CompanyDetails} />
        <Route path="/complains" exact component={ComplainHome} />
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
    </BrowserRouter>
  )
}

export default App
