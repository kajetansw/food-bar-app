import { createContext } from '@marblejs/core';
import { Server } from '@connection';
import httpListener from '@app';

const bootstrap = async () => {
  await Server.create(httpListener.run(createContext()));
};

bootstrap();