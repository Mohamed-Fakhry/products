import { Injectable } from "@nestjs/common";
import { InjectModel } from "nestjs-typegoose";
import { BaseRepository, ModelType } from "src/shared/base.repository";
import { Product } from "../entities/product.entity";

@Injectable()
export class ProductsRepository extends BaseRepository<Product> {
    constructor(@InjectModel(Product) private readonly orderModel: ModelType<Product>) {
        super(orderModel);
    }

    async createProduct(doc?: Partial<Product>): Promise<Product> {
        const product = this.createModel(doc);
        return await this.create(product);
    }
}