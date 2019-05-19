import { createServer } from '@marblejs/core';
import httpListener from './app';

export const server = createServer({
  port: 8888,
  hostname: 'localhost',
  httpListener
});

server.run();
