import { Recipe } from '@api/recipe/model/recipe.model';
import { from } from 'rxjs';

export namespace RecipeDao {
  export const model = new Recipe().getModelForClass(Recipe);
  
  export const findAll = () => from(
    model.find()
      .select({ _id: 0 })
      .exec()
  );
}