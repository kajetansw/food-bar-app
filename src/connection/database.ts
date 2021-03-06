import * as mongoose from 'mongoose';
import chalk from 'chalk';
import { Config } from '@config';

export namespace Database {
  const { mongoUser, mongoPassword, mongoDb } = Config.db;

  const onOpen = () => {
    console.info(chalk.green('[database] connected'));
  };

  const onError = (error: mongoose.Error) => {
    console.error(chalk.red(`[database] connection error: ${error.message}`));
    process.exit();
  };

  export const connect = () =>
    mongoose
      .connect(
        `mongodb+srv://${mongoUser}:${mongoPassword}@cluster0-a2ga4.mongodb.net/${mongoDb}?retryWrites=true`,
        { useNewUrlParser: true }
      )
      .then(onOpen)
      .catch(onError);

  /*export const connectTest = () =>
    mongoose
      .connect(urlTest + '/' + uuid.v4(), { useNewUrlParser: true });*/

  export const disconnect = () =>
    mongoose.disconnect();

  export const drop = () =>
    mongoose.connection.dropDatabase();
}