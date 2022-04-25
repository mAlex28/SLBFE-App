import { BrowserRouter, Route, Navigate, Routes } from 'react-router-dom'

import SignUp from './components/Auth/Citizen/Auth'
import Home from './components/Home/Home'
import Navbar from './components/Navbar/Navbar'
import Profile from './components/Profile/Profile'

function App() {
  const user = JSON.parse(localStorage.getItem('profile'))
  return (
    <BrowserRouter>
      <Navbar />
      <Routes>
        <Route
          path="/"
          element={
            !user ? (
              <Navigate replace to="/auth" />
            ) : (
              <Navigate replace to="/citizen" />
            )
          }
        />
        <Route path="/citizen" element={<Home />} />
        <Route path="/citizen/search" element={<Home />} />
        <Route path="/citizen/:id" element={<Profile />} />
        <Route
          path="/auth"
          exact
          element={!user ? <SignUp /> : <Navigate replace to="/citizen" />}
        />
      </Routes>
    </BrowserRouter>
  )
}

export default App
