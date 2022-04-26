import { BrowserRouter, Route, Navigate, Routes } from 'react-router-dom'

import SignUp from './components/Auth/Citizen/Auth'
import Navbar from './components/Navbar/Navbar'
import Profile from './components/Profile/Profile'
import TabItems from './components/TabItems/TabItems'

function App() {
  const user = JSON.parse(localStorage.getItem('profile'))
  return (
    <BrowserRouter>
      <Navbar />
      <Routes>
        <Route path="/" element={!user ? <SignUp /> : <TabItems />} />
        <Route path="/citizen" element={<TabItems />} />
        <Route path="/citizen/search" element={<TabItems />} />
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
