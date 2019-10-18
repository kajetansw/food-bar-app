import { HttpEffect } from '@marblejs/core';
import { flatMap, map } from 'rxjs/operators';
import { RecipeDao } from '@api/recipe/model';

export const getAllRecipesEffect$: HttpEffect = req$ => req$.pipe(
  flatMap(RecipeDao.findAll),
  map(body => ({ body }))
);