import React from 'react'
import { Provider } from 'react-redux'
import ReactDOM from 'react-dom/client'
import thunk from 'redux-thunk'
import './index.css'
import App from './App'
import {
  legacy_createStore as createStore,
  applyMiddleware,
  compose,
} from 'redux'
import { reducers } from './reducers'

const root = ReactDOM.createRoot(document.getElementById('root'))
const store = createStore(reducers, {}, compose(applyMiddleware(thunk)))

root.render(
  <Provider store={store}>
    <App />
  </Provider>
)
