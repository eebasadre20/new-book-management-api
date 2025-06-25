import { Controller, Get, Put, Param, Body } from '@nestjs/common';
import { ReaderService } from '../services/reader.service';
import { UpdateCurrentBookDto } from '../dtos/update-current-book.dto';

@Controller('readers')
export class ReaderController {
  constructor(private readonly readerService: ReaderService) {}

  @Get(':id/current-book')
  async getCurrentBook(@Param('id') id: number) {
    return this.readerService.getCurrentBook(id);
  }

  @Put(':id/current-book')
  async updateCurrentBook(@Param('id') id: number, @Body() updateCurrentBookDto: UpdateCurrentBookDto) {
    return this.readerService.updateCurrentBook(id, updateCurrentBookDto);
  }
}
