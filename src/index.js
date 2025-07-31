import React from 'react';
import ReactDOM from 'react-dom/client';
import {Route, HashRouter as Router, Switch} from 'react-router-dom';
import './index.css';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <Router baseline='/'>
    <App />
  </Router>
);
