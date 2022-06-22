import { createParamDecorator, ExecutionContext } from "@nestjs/common";


export const AddParamsToBody = createParamDecorator(
  (_: any, ctx: ExecutionContext) => {
  return ctx.switchToHttp().getRequest().body = {
    ...ctx.switchToHttp().getRequest().body, 
    ...ctx.switchToHttp().getRequest().params
  }
});