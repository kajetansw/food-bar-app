import { r } from '@marblejs/core';
import { logger$ } from '@api/common/middlewares/logger.middleware';
import { getAllRecipesEffect$, saveRecipeEffect$ } from '@api/recipe/effects';

export const getAllRecipes$ = r.pipe(
  r.matchPath('/recipes'),
  r.matchType('GET'),
  r.use(logger$),
  r.useEffect(getAllRecipesEffect$)
);

export const saveRecipe$ = r.pipe(
  r.matchPath('/recipe/save'),
  r.matchType('POST'),
  r.use(logger$),
  r.useEffect(saveRecipeEffect$)
);