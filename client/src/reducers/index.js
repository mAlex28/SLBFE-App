import { combineReducers } from 'redux';

import citizens from './citizens';
import companies from './companies'
import auth from './auth';

export const reducers = combineReducers({ companies, citizens, auth });
