import { HttpEffect } from '@marblejs/core';
import { map, tap } from 'rxjs/operators';
import { Recipe, RecipeDao } from '@api/recipe/model';

export const saveRecipeEffect$: HttpEffect = req$ => req$.pipe(
  map(req => <Recipe>req.body),
  tap(RecipeDao.save),
  map(recipe => ({ body: recipe }))
);