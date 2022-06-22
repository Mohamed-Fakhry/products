import { Prop } from "@typegoose/typegoose";
import { BaseModel } from "src/shared/base.model";

export class Product extends BaseModel {
    @Prop()
    name: string;

    @Prop()
    description: string;

    @Prop()
    price: number;

    @Prop()
    brand: string;
}
