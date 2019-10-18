import { combineRoutes, r } from '@marblejs/core';
import { helloEffect$ } from '@api/hello';
import { logger$ } from './common/middlewares/logger.middleware';
import { recipeEffect$ } from '@api/recipe';

const hello$ = r.pipe(
  r.matchPath('/'),
  r.matchType('GET'),
  r.use(logger$),
  r.useEffect(helloEffect$)
);

const recipe$ = r.pipe(
  r.matchPath('/recipe'),
  r.matchType('POST'),
  r.use(logger$),
  r.useEffect(recipeEffect$)
);

export const api$ = combineRoutes('/api', [
  hello$,
  recipe$
]);