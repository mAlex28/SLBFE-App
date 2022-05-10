import { FETCH_ALL, FETCH_BY_CREATOR, CREATE } from '../constants/actionTypes';

export default (state = { isLoading: true, complains: [] }, action) => {
    switch (action.type) {
        case 'START_LOADING':
            return { ...state, isLoading: true };
        case 'END_LOADING':
            return { ...state, isLoading: false };
        case FETCH_ALL:
            return {
                ...state,
                complains: action.payload.data,
                currentPage: action.payload.currentPage,
                numberOfPages: action.payload.numberOfPages,
            };
        case FETCH_BY_CREATOR:
            return { ...state, complains: action.payload.data };
        case CREATE:
            return { ...state, complains: [...state.complains, action.payload] };
        default:
            return state;
    }
};

