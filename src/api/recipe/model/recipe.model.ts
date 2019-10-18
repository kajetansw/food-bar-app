import { prop, Typegoose } from 'typegoose';

export class Recipe extends Typegoose {
  @prop({ required: true })
  title?: string;
  
  @prop({ required: true})
  description?: string;
  
  @prop({ required: true })
  preparationTime?: number;
}