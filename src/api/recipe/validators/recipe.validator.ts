import { t } from '@marblejs/middleware-io';

export const recipeSchema = t.type({
  title: t.string,
  description: t.string,
  preparationTime: t.number
});

export type Recipe = t.TypeOf<typeof recipeSchema>;