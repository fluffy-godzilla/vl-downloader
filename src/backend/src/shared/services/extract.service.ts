import { Injectable, Logger } from '@nestjs/common';
import { RomEntity } from '../../rom/rom.entity';

@Injectable()
export class ExtractService {
  private readonly logger = new Logger(ExtractService.name);

  async extract(rom: RomEntity): Promise<void> {
    // TODO: 7z extraction logic to be implemented here
  }
}
