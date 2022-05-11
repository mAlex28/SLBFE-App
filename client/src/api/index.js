import axios from 'axios';

// hosted URL: https://slbfe-api-app.herokuapp.com/ - replace this with following baseURL to use the deployed version
// Please note: Deployed version only resturn JSON reponses
const API = axios.create({ baseURL: 'http://localhost:5000' });

API.interceptors.request.use((req) => {
  if (localStorage.getItem('profile')) {
    req.headers.Authorization = `Bearer ${JSON.parse(localStorage.getItem('profile')).token}`;
  }

  return req;
});

export const fetchCitizen = (id) => API.get(`/citizens/${id}`);
export const fetchCitizens = (page) => API.get(`/citizens?page=${page}`);
export const fetchCitizensByName = (name) => API.get(`/citizens/creator?name=${name}`);
export const fetchCitizensBySearch = (searchQuery) => API.get(`/citizens/search?nicQuery=${searchQuery.search || 'none'}&nameQuery=${searchQuery.name || 'none'}&qualifications=${searchQuery.tags}`);
export const updateCitizen = (id, updatedCitizen) => API.patch(`/citizens/${id}`, updatedCitizen);
export const deleteCitizen = (id) => API.delete(`/citizens/${id}`);

export const fetchCompany = (id) => API.get(`/companies/${id}`)
export const fetchCompanies = (page) => API.get(`/companies?page=${page}`);
export const fetchCompaniesBySearch = (searchQuery) => API.get(`/companies/search?searchQuery=${searchQuery.search || 'none'}&companyFields=${searchQuery.tags}`);
export const updateCompany = (id, updatedCompany) => API.patch(`/companies/${id}`, updatedCompany);
export const deleteCompany = (id) => API.delete(`/companies/${id}`);

export const fetchComplains = (page) => API.get(`complains?page=${page}`);
export const fetchComplainsByCreator = (email) => API.get(`complains/creator?email=${email}`);
export const createComplains = (complain) => API.post('complains/create', complain);

export const signIn = (formData) => API.post('/officers/signin', formData);
export const signUp = (formData) => API.post('/officers/signup', formData);

export const citizenSignIn = (formData) => API.post('/citizens/signin', formData);
export const citizenSignUp = (formData) => API.post('/citizens/signup', formData);