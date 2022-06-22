import { IsPositive, IsString } from "class-validator";

export class CreateProductDto {

    @IsString()
    name: string;

    @IsString()
    description: string;

    @IsPositive()
    price: number;

    @IsString()
    brand: string;
}
