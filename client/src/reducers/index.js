import { combineReducers } from 'redux';

import posts from './posts';
import companies from './companies'
import auth from './auth';

export const reducers = combineReducers({ companies, posts, auth });
