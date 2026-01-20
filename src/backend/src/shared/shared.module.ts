import { Module } from '@nestjs/common';
import { UtilsService } from './services/utils.service';
import { ConfigModule } from '@nestjs/config';
import { DownloadService } from './services/download.service';
import { ExtractService } from './services/extract.service';

@Module({
  imports: [ConfigModule],
  providers: [UtilsService, DownloadService, ExtractService],
  controllers: [],
  exports: [UtilsService, DownloadService, ExtractService],
})
export class SharedModule {}
