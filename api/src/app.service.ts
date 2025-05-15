import { Injectable } from '@nestjs/common';
import { detectDisease } from './utils/detector';

@Injectable()
export class AppService {
  async detect(file: Express.Multer.File) {
    const result = await detectDisease(file);
    if (result instanceof Error) {
      throw result;
    }
    return result;
  }
}
