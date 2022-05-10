import { START_LOADING, END_LOADING, FETCH_ALL, FETCH_POST, FETCH_BY_SEARCH, CREATE, UPDATE, DELETE } from '../constants/actionTypes';
import * as api from '../api/index.js';

export const getCompany = (id) => async (dispatch) => {
    try {
        dispatch({ type: START_LOADING });

        const { data } = await api.fetchCompany(id);

        dispatch({ type: FETCH_POST, payload: { company: data } });
    } catch (error) {
        console.log(error);
    }
};

export const getCompanies = (page) => async (dispatch) => {
    try {
        dispatch({ type: START_LOADING });
        const { data: { data, currentPage, numberOfPages } } = await api.fetchCompanies(page);

        dispatch({ type: FETCH_ALL, payload: { data, currentPage, numberOfPages } });
        dispatch({ type: END_LOADING });
    } catch (error) {
        console.log(error);
    }
};

export const getCompanyBySearch = (searchQuery) => async (dispatch) => {
    try {
        dispatch({ type: START_LOADING });
        const { data: { data } } = await api.fetchCompaniesBySearch(searchQuery);

        dispatch({ type: FETCH_BY_SEARCH, payload: { data } });
        dispatch({ type: END_LOADING });
    } catch (error) {
        console.log(error);
    }
};

export const updateCompany = (id, company) => async (dispatch) => {
    try {
        const { data } = await api.updateCompany(id, company);

        dispatch({ type: UPDATE, payload: data });
    } catch (error) {
        console.log(error);
    }
};

export const deleteCompany = (id) => async (dispatch) => {
    try {
        await await api.deleteCompany(id);

        dispatch({ type: DELETE, payload: id });
    } catch (error) {
        console.log(error);
    }
};
