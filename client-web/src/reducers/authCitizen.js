import * as actionType from '../constants/actionTypes'

const authReducer = (state = { authData: null }, action) => {
  switch (action.type) {
    case actionType.AUTH:
      localStorage.setItem('profile', JSON.stringify({ ...action?.data }))
      // localStorage.setItem('usertype', )

      return { ...state, authData: action.data, loading: false, errors: null }
    case actionType.LOGOUT_CITIZEN:
      localStorage.clear()
      return { ...state, authData: null, loading: false, errors: null }
    default:
      return state
  }
}

export default authReducer
