import { ENV } from './env';

export enum NodeEnv {
  PRODUCTION = 'production',
  DEVELOPMENT = 'development',
}

export type LoggerLevel = 'dev' | 'prod';

interface IConfig {
  env: NodeEnv;
  server: {
    host: string;
    port: number;
  };
  db: {
    mongoUser: string;
    mongoPassword: string;
    mongoDb: string;
  };
  logger: {
    level: LoggerLevel;
  };
  jwt: {
    secret: string,
  };
}

export const Config: IConfig = {
  env: process.env.NODE_ENV as NodeEnv || ENV.NODE_ENV,
  server: {
    host: process.env.HOST || ENV.SERVER_HOST,
    port: Number(process.env.PORT) || ENV.SERVER_PORT,
  },
  db: {
    mongoUser: process.env.MONGO_USER || ENV.MONGO_USER,
    mongoPassword: process.env.MONGO_PASSWORD || ENV.MONGO_PASSWORD,
    mongoDb: process.env.MONGO_DB || ENV.MONGO_DB
  },
  logger: {
    level: process.env.LOG_LEVEL as LoggerLevel || ENV.LOG_LEVEL,
  },
  jwt: {
    secret: ENV.JWT_SECRET,
  },
};