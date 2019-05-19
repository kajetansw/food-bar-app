import { combineRoutes, r } from '@marblejs/core';
import { helloEffect$ } from '@api/hello';
import { logger$ } from './common/middlewares/logger.middleware';

const hello$ = r.pipe(
  r.matchPath('/'),
  r.matchType('GET'),
  r.use(logger$),
  r.useEffect(helloEffect$)
);

export const api$ = combineRoutes('/api', [
  hello$
]);