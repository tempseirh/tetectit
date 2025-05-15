import { IsNotEmpty, IsString } from 'class-validator';

export class FileValidationDto {
  @IsNotEmpty()
  @IsString()
  fieldname!: string;

  @IsNotEmpty()
  @IsString()
  originalname!: string;

  @IsNotEmpty()
  @IsString()
  mimetype!: string;

  @IsNotEmpty()
  buffer!: Buffer;

  @IsNotEmpty()
  size!: number;
}
