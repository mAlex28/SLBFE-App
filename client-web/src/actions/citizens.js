import {
  AUTH,
  DELETE_CITIZEN,
  END_LOADING,
  FETCH_ALL_CITIZENS,
  FETCH_BY_CITIZEN_NAME,
  FETCH_CITIZEN,
  FETCH_CITIZEN_BY_SEARCH,
  GET_CITIZEN,
  START_LOADING,
  UPDATE_CITIZEN,
} from '../constants/actionTypes'
import * as api from '../api/index.js'

export const signin = (formData, router) => async (dispatch) => {
  try {
    const { data } = await api.citizenSignIn(formData)

    dispatch({ type: AUTH, data })

    router.push('/')
  } catch (error) {
    console.log(error)
  }
}
export const signup = (formData, router) => async (dispatch) => {
  try {
    const { data } = await api.citizenSignUp(formData)
    console.log(data)

    dispatch({ type: AUTH, data })
    console.log('afteridspatch', data)

    router.push('/')
  } catch (error) {
    console.log(error)
  }
}

export const getUser = (id) => async (dispatch) => {
  try {
    const { data } = await api.getUser(id)

    dispatch({ type: GET_CITIZEN, payload: { user: data } })
  } catch (error) {
    console.log(error)
  }
}

export const getCitizen = (id) => async (dispatch) => {
  try {
    dispatch({ type: START_LOADING })
    const { data } = await api.fetchCitizen(id)

    dispatch({ type: FETCH_CITIZEN, payload: { citizen: data } })
  } catch (error) {
    console.log(error)
  }
}

export const getAllCitizens = (page) => async (dispatch) => {
  try {
    dispatch({ type: START_LOADING })
    const {
      data: { data, currentPage, numberOfPages },
    } = await api.fetchCitizens(page)

    dispatch({
      type: FETCH_ALL_CITIZENS,
      payload: { data, currentPage, numberOfPages },
    })
    dispatch({ type: END_LOADING })
  } catch (error) {
    console.log(error)
  }
}

export const updateCitizen = (id, citizen) => async (dispatch) => {
  try {
    const { data } = await api.updateCitizen(id, citizen)
    dispatch({ type: UPDATE_CITIZEN, payload: data })
  } catch (error) {
    console.log(error)
  }
}

export const deleteCitizen = (id) => async (dispatch) => {
  try {
    await api.deleteCitizen(id)
    dispatch({ type: DELETE_CITIZEN, payload: id })
  } catch (error) {
    console.log(error)
  }
}

export const getCitizensBySearch = (searchQuery) => async (dispatch) => {
  try {
    dispatch({ type: START_LOADING })
    const {
      data: { data },
    } = await api.fetchCitizensBySearch(searchQuery)
    dispatch({ type: FETCH_CITIZEN_BY_SEARCH, payload: { data } })
    dispatch({ type: END_LOADING })
  } catch (error) {
    console.log(error)
  }
}

export const getCitizenByName = (name) => async (dispatch) => {
  try {
    const {
      data: { data },
    } = await api.fetchCitizensByName(name)

    dispatch({ type: FETCH_BY_CITIZEN_NAME, payload: { data } })
    dispatch({ type: END_LOADING })
  } catch (error) {
    console.log(error)
  }
}