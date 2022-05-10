import { combineReducers } from 'redux';

import citizens from './citizens';
import companies from './companies';
import complains from './complains';
import auth from './auth';

export const reducers = combineReducers({ complains, companies, citizens, auth });
