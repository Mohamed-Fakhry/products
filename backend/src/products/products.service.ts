import { Injectable } from '@nestjs/common';
import { CreateProductDto } from './dto/create-product.dto';
import { UpdateProductDto } from './dto/update-product.dto';
import { ProductsRepository } from './repositories/products.repository';

@Injectable()
export class ProductsService {
  constructor(
    private productsRepository: ProductsRepository
  ) { }

  async create(createProductDto: CreateProductDto) {
    return await this.productsRepository.createProduct(createProductDto);
  }

  async findAll(paginateionDto?: PaginateionDto) {
    return await this.productsRepository.findAll(paginateionDto);
  }

  async findOne(id: string) {
    return await this.productsRepository.findById(id);
  }

  async update(id: string, updateProductDto: UpdateProductDto) {
    return await this.productsRepository.updateById(id, updateProductDto);
  }

  remove(id: string) {
    return this.productsRepository.deleteById(id);
  }
}
