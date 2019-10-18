import { HttpEffect } from '@marblejs/core';
import { map, tap } from 'rxjs/operators';

export const recipeEffect$: HttpEffect = req$ => req$.pipe(
  tap(req => console.log(req.body)), // TODO remove after connecting with Elm form
  map(req => ({ body: req.body }))
);