import { InternalServerErrorException } from '@nestjs/common';
import { DocumentType, ReturnModelType } from '@typegoose/typegoose';
import { AnyParamConstructor } from '@typegoose/typegoose/lib/types';
import {
  CreateQuery,
  DocumentQuery,
  FilterQuery,
  PaginateOptions,
  PaginateResult,
  Query,
  QueryFindOneAndUpdateOptions,
  Types,
  UpdateQuery,
} from 'mongoose';
import { MongoError } from 'mongodb';
import { BaseModel } from './base.model';

type QueryList<T extends BaseModel> = DocumentQuery<Array<DocumentType<T>>, DocumentType<T>>;
type QueryItem<T extends BaseModel> = DocumentQuery<DocumentType<T>, DocumentType<T>>;

interface QueryOptions {
  lean?: boolean;
  autopopulate?: boolean;
}

export type ModelType<TModel extends BaseModel> = ReturnModelType<AnyParamConstructor<TModel>>;

export abstract class BaseRepository<TModel extends BaseModel> {
  protected model: ModelType<TModel>;

  protected constructor(model: ModelType<TModel>) {
    this.model = model;
  }

  private static get defaultOptions(): QueryOptions {
    return { lean: false, autopopulate: true };
  }

  private static getQueryOptions(options?: QueryOptions) {
    const mergedOptions = {
      ...BaseRepository.defaultOptions,
      ...(options || {}),
    };
    // const option = !mergedOptions.lean ? { virtuals: true } : null;

    // if (option && mergedOptions.autopopulate) {
    //   option['autopopulate'] = true;
    // }

    return { lean: false, autopopulate: mergedOptions.autopopulate };
  }

  protected static throwMongoError(err: MongoError): void {
    throw new InternalServerErrorException(err, err.errmsg);
  }

  createModel(doc?: Partial<TModel>): TModel {
    return new this.model(doc);
  }

  findAll(paginateionDto?: PaginateionDto, query = {}, sort = {}, options?: QueryOptions) {
    return (paginateionDto) ?
      this
        .paginate(
          query,
          {
            ...paginateionDto,
            ...(sort && { sort }),
          }
        ) :
      this.model.find(query, sort)
        .setOptions(BaseRepository.getQueryOptions(options))
        .sort(sort)
        .exec();
  }

  findOne(options?: QueryOptions, query?) {
    return this.model.findOne(query).setOptions(BaseRepository.getQueryOptions(options));
  }

  findById(id: string, options?: QueryOptions) {
    return this.model
      .findById(Types.ObjectId(id))
      .setOptions(BaseRepository.getQueryOptions(options));
  }

  async create(item: CreateQuery<TModel>): Promise<DocumentType<TModel>> {
    try {
      return await this.model.create(item);
    } catch (e) {
      console.log(e);
      BaseRepository.throwMongoError(e);
    }
  }

  deleteOne(options?: QueryOptions) {
    return this.model.findOneAndDelete().setOptions(BaseRepository.getQueryOptions(options));
  }

  deleteById(id: string, options?: QueryOptions) {
    return this.model
      .findByIdAndDelete(Types.ObjectId(id))
      .setOptions(BaseRepository.getQueryOptions(options));
  }

  update(item: TModel, options?: QueryOptions) {
    return this.model
      .findByIdAndUpdate(Types.ObjectId(item.id), { $set: item } as any, {
        omitUndefined: true,
        new: true,
      })
      .setOptions(BaseRepository.getQueryOptions(options));
  }

  updateById(
    id: string,
    updateQuery: UpdateQuery<DocumentType<TModel>>,
    updateOptions: QueryFindOneAndUpdateOptions & { multi?: boolean } = {},
    options?: QueryOptions,
  ) {
    return this.updateByFilter(
      { _id: Types.ObjectId(id) as any },
      updateQuery,
      updateOptions,
      options,
    );
  }

  updateByFilter(
    filter: FilterQuery<DocumentType<TModel>> = {},
    updateQuery: UpdateQuery<DocumentType<TModel>>,
    updateOptions: QueryFindOneAndUpdateOptions = {},
    options?: QueryOptions,
  ) {
    return this.model
      .findOneAndUpdate(filter, updateQuery, {
        ...Object.assign({ omitUndefined: true }, updateOptions),
        new: true,
      })
      .setOptions(BaseRepository.getQueryOptions(options));
  }

  async exists(filter: FilterQuery<DocumentType<TModel>> = {}): Promise<boolean> {
    try {
      return await this.model.exists(filter);
    } catch (e) {
      BaseRepository.throwMongoError(e);
    }
  }

  async count(query?) {
    return await this.model.countDocuments(query);
  }

  async paginate(
    query?: FilterQuery<TModel>,
    options?: PaginateOptions,
    callback?: (err: Error, result: PaginateResult<TModel>) => void,
  ): Promise<PaginateResult<TModel>> {
    return await (this.model as any).paginate(query, options, callback);
  }
}