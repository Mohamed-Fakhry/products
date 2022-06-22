import { modelOptions, plugin, Prop, Severity, } from '@typegoose/typegoose';
import { useMongoosePlugin } from './decorators/use-mongoose-plugins.decorator';

import { FilterQuery, PaginateOptions, PaginateResult } from 'mongoose';

type PaginateMethod<T> = (
  query?: FilterQuery<T>,
  options?: PaginateOptions,
  callback?: (err: any, result: PaginateResult<T>) => void,
) => Promise<PaginateResult<T>>;
@modelOptions({
  options: { allowMixed: Severity.ALLOW },
  schemaOptions: {
    timestamps: true,
    toJSON: {
      versionKey: false,
      virtuals: true,
      getters: true,
      transform: (_, doc: Record<string, unknown>) => {
        const id = doc._id;

        const privateKeys = Object.keys(doc).filter((key) =>
          key.startsWith('_'),
        );

        privateKeys.forEach((key) => delete doc[key]);

        return { id, ...doc };
      },
    },
  },
})
@useMongoosePlugin()
export abstract class BaseModel {
  id: string;

  @Prop()
  createdAt: Date;

  @Prop()
  updatedAt: Date;

  static paginate: PaginateMethod<BaseModel>;
}
