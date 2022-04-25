import * as actionType from '../constants/actionTypes'

const authReducer = (
  state = { authData: null, isLoading: true, users: [] },
  action
) => {
  switch (action.type) {
    case actionType.START_LOADING:
      return { ...state, isLoading: true }
    case actionType.END_LOADING:
      return { ...state, isLoading: false }
    case actionType.AUTH:
      localStorage.setItem('profile', JSON.stringify({ ...action?.data }))
      return { ...state, authData: action.data, loading: false, errors: null }
    case actionType.LOGOUT_CITIZEN:
      localStorage.clear()
      return { ...state, authData: null, loading: false, errors: null }
    case actionType.GET_CITIZEN:
    case actionType.FETCH_CITIZEN:
      return { ...state, user: action.payload.user }
    case actionType.FETCH_ALL_CITIZENS:
      return { ...state, users: action.payload.data }
    case actionType.UPDATE_CITIZEN:
      return {
        ...state,
        users: state.users.map((user) =>
          user._id === action.payload._id ? action.payload : user
        ),
      }
    case actionType.DELETE_CITIZEN:
      return {
        ...state,
        users: state.users.filter((user) => user._id !== action.payload),
      }
    case actionType.FETCH_CITIZEN_BY_SEARCH:
    case actionType.FETCH_BY_CITIZEN_NAME:
    case actionType.FETCH_BY_NIC:
      return { ...state, users: action.payload.data }
    default:
      return state
  }
}

export default authReducer
