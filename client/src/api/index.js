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
export const fetchPostsBySearch = (searchQuery) => API.get(`/citizens/search?searchQuery=${searchQuery.search || 'none'}&tags=${searchQuery.tags}`);
export const createPost = (newPost) => API.post('/citizens', newPost);
export const likePost = (id) => API.patch(`/citizens/${id}/likePost`);
export const comment = (value, id) => API.post(`/citizens/${id}/commentPost`, { value });
export const updatePost = (id, updatedPost) => API.patch(`/citizens/${id}`, updatedPost);
export const deletePost = (id) => API.delete(`/citizens/${id}`);

export const signIn = (formData) => API.post('/officers/signin', formData);
export const signUp = (formData) => API.post('/officers/signup', formData);