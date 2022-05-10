import { FETCH_ALL, FETCH_BY_SEARCH, FETCH_BY_CREATOR, FETCH_POST, UPDATE, DELETE } from '../constants/actionTypes';

export default (state = { isLoading: true, citizens: [] }, action) => {
  switch (action.type) {
    case 'START_LOADING':
      return { ...state, isLoading: true };
    case 'END_LOADING':
      return { ...state, isLoading: false };
    case FETCH_ALL:
      return {
        ...state,
        citizens: action.payload.data,
        currentPage: action.payload.currentPage,
        numberOfPages: action.payload.numberOfPages,
      };
    case FETCH_BY_SEARCH:
    case FETCH_BY_CREATOR:
      return { ...state, citizens: action.payload.data };
    case FETCH_POST:
      return { ...state, citizen: action.payload.citizen };
    case UPDATE:
      return { ...state, citizens: state.citizens.map((citizen) => (citizen._id === action.payload._id ? action.payload : citizen)) };
    case DELETE:
      return { ...state, citizens: state.citizens.filter((citizen) => citizen._id !== action.payload) };
    default:
      return state;
  }
};

