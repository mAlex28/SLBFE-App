import * as actionType from '../constants/actionTypes'

export default (state = { isLoading: true, citizens: [] }, action) => {
  switch (action.type) {
    case actionType.START_LOADING:
      return { ...state, isLoading: true }
    case actionType.END_LOADING:
      return { ...state, isLoading: false }
    case actionType.FETCH_CITIZEN:
      return { ...state, citizen: action.payload.citizen }
    case actionType.FETCH_ALL_CITIZENS:
      return {
        ...state,
        citizens: action.payload.data,
        currentPage: action.payload.currentPage,
        numberOfPages: action.payload.numberOfPages,
      }
    case actionType.UPDATE_CITIZEN:
      return {
        ...state,
        citizens: state.citizens.map((citizen) =>
          citizen._id === action.payload._id ? action.payload : citizen
        ),
      }
    case actionType.DELETE_CITIZEN:
      return {
        ...state,
        citizens: state.citizens.filter(
          (citizen) => citizen._id !== action.payload
        ),
      }
    case actionType.FETCH_CITIZEN_BY_SEARCH:
    case actionType.FETCH_BY_CITIZEN_NAME:
    case actionType.FETCH_BY_NIC:
      return { ...state, citizens: action.payload.data }
    default:
      return state
  }
}
