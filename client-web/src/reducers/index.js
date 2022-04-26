import { combineReducers } from 'redux'

import auth from './authCitizen'
import citizens from './citizens'

export const reducers = combineReducers({ auth, citizens })
