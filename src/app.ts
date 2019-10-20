import { httpListener } from '@marblejs/core';
import { api$ } from './api';
import { bodyParser$ } from '@marblejs/middleware-body';
import { cors$ } from '@marblejs/middleware-cors';

export const middlewares = [
  bodyParser$(),
  cors$({
    origin: '*',
    allowHeaders: '*',
    methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS']
  })
];

const effects = [
  api$
];

export default httpListener({ middlewares, effects });