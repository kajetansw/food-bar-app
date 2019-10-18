import { httpListener } from '@marblejs/core';
import { api$ } from './api';
import { bodyParser$ } from '@marblejs/middleware-body';

export const middlewares = [bodyParser$()];

const effects = [
  api$
];

export default httpListener({ middlewares, effects });