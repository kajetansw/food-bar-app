import { HttpEffect, use } from '@marblejs/core';
import { map, tap } from 'rxjs/operators';
import { Recipe, RecipeDao } from '@api/recipe/model';
import { requestValidator$ } from '@marblejs/middleware-io';
import { recipeSchema } from '@api/recipe/validators';

export const saveRecipeEffect$: HttpEffect = req$ => req$.pipe(
  use(requestValidator$({ body: recipeSchema })),
  map(req => <Recipe>req.body),
  tap(RecipeDao.save),
  map(recipe => ({ body: recipe }))
);