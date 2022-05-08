import axios from 'axios'

// To Use the hosted API - https://slbfe-api-app.herokuapp.com/
const API = axios.create({ baseURL: 'http://localhost:5000/' })

API.interceptors.request.use((req) => {
  if (localStorage.getItem('profile')) {
    req.headers.Authorization = `Bearer ${
      JSON.parse(localStorage.getItem('profile')).token
    }`
  }

  return req
})

// CITIZEN APIs
export const citizenSignIn = (formData) => API.post('/citizen/signin', formData)
export const citizenSignUp = (formData) => API.post('/citizen/signup', formData)
export const deleteCitizen = (id) => API.delete(`/citizen/${id}`)
export const updateCitizen = (id, updatedCitizen) =>
  API.patch(`/citizen/${id}`, updatedCitizen)
export const fetchCitizen = (id) => API.get(`/citizen/${id}`)
export const fetchCitizens = (page) => API.get(`/citizen?page=${page}`)
export const fetchCitizensByName = (name) =>
  API.get(`/citizen/citizenname?name=${name}`)
export const fetchCitizensBySearch = (searchQuery) =>
  API.get(
    `/citizen/search?searchQuery=${
      searchQuery.searchQuery || 'none'
    }&qualifications=${searchQuery.qualifications}`
  )
