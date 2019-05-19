import { HttpEffect } from '@marblejs/core';
import { mapTo } from 'rxjs/operators';

export const helloEffect$: HttpEffect = req$ => req$.pipe(
  mapTo({ body: 'Hello world!' })
);
