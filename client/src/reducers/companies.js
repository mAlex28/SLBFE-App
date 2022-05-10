import { FETCH_ALL, FETCH_BY_SEARCH, FETCH_POST, UPDATE, DELETE } from '../constants/actionTypes';

export default (state = { isLoading: true, companies: [] }, action) => {
    switch (action.type) {
        case 'START_LOADING':
            return { ...state, isLoading: true };
        case 'END_LOADING':
            return { ...state, isLoading: false };
        case FETCH_ALL:
            return {
                ...state,
                companies: action.payload.data,
                currentPage: action.payload.currentPage,
                numberOfPages: action.payload.numberOfPages,
            };
        case FETCH_BY_SEARCH:
            return { ...state, companies: action.payload.data };
        case FETCH_POST:
            return { ...state, company: action.payload.company };
        case UPDATE:
            return { ...state, companies: state.companies.map((company) => (company._id === action.payload._id ? action.payload : company)) };
        case DELETE:
            return { ...state, companies: state.companies.filter((company) => company._id !== action.payload) };
        default:
            return state;
    }
};

