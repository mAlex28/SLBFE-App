import React from 'react'
import { Provider } from 'react-redux'
import ReactDOM from 'react-dom/client'
import thunk from 'redux-thunk'
import './index.css'
import App from './App'
import { legacy_createStore as createStore, applyMiddleware } from 'redux'
import { reducers } from './reducers'
import { composeWithDevTools } from 'redux-devtools-extension'

const root = ReactDOM.createRoot(document.getElementById('root'))
const store = createStore(reducers, composeWithDevTools(applyMiddleware(thunk)))

root.render(
  <Provider store={store}>
    <App />
  </Provider>
)
