import { Injectable } from '@nestjs/common';
import { Reader } from '../models/reader.model';
import { UpdateCurrentBookDto } from '../dtos/update-current-book.dto';

@Injectable()
export class ReaderService {
  private readers: Reader[] = []; // This should be replaced with actual database logic

  getCurrentBook(readerId: number): Reader {
    const reader = this.readers.find(r => r.id === readerId);
    if (!reader) {
      throw new Error('Reader not found');
    }
    return reader.currentBookId;
  }

  updateCurrentBook(readerId: number, updateCurrentBookDto: UpdateCurrentBookDto): Reader {
    const reader = this.readers.find(r => r.id === readerId);
    if (!reader) {
      throw new Error('Reader not found');
    }
    reader.currentBookId = updateCurrentBookDto.currentBookId;
    return reader;
  }
}
