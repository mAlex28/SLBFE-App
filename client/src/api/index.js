import axios from 'axios';

const API = axios.create({ baseURL: 'http://localhost:5000' });

API.interceptors.request.use((req) => {
  if (localStorage.getItem('profile')) {
    req.headers.Authorization = `Bearer ${JSON.parse(localStorage.getItem('profile')).token}`;
  }

  return req;
});

export const fetchPost = (id) => API.get(`/citizens/${id}`);
export const fetchPosts = (page) => API.get(`/citizens?page=${page}`);
export const fetchPostsByCreator = (name) => API.get(`/citizens/creator?name=${name}`);
export const fetchPostsBySearch = (searchQuery) => API.get(`/citizens/search?searchQuery=${searchQuery.search || 'none'}&qualifications=${searchQuery.tags}`);
export const createPost = (newPost) => API.post('/citizens', newPost);
export const comment = (value, id) => API.post(`/citizens/${id}/commentPost`, { value });
export const updatePost = (id, updatedPost) => API.patch(`/citizens/${id}`, updatedPost);
export const deletePost = (id) => API.delete(`/citizens/${id}`);

export const fetchCompany = (id) => API.get(`companies`)
export const fetchCompanies = (page) => API.get(`/companies?page=${page}`);
export const fetchCompaniesBySearch = (searchQuery) => API.get(`/companies/search?searchQuery=${searchQuery.search || 'none'}&companyFields=${searchQuery.tags}`);
export const updateCompany = (id, updatedCompany) => API.patch(`/companies/${id}`, updatedCompany);
export const deleteCompany = (id) => API.delete(`/companies/${id}`);

export const fetchComplains = (page) => API.get(`complains?page=${page}`);
export const fetchComplainsByCreator = (name) => API.get(`complains/creator?name=${name}`);
export const createComplains = (complain) => API.post('complains/create', complain);

export const signIn = (formData) => API.post('/officers/signin', formData);
export const signUp = (formData) => API.post('/officers/signup', formData);