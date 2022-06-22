import { NestFactory } from '@nestjs/core';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { AppModule } from './app.module';

function buildSwagger() {
  const config = new DocumentBuilder()
    .setTitle('Orders Api')
    .setVersion('v0.1.0')
    .addBearerAuth();

  config
    .addServer('http://localhost:3000/', 'Localhost server');

  const configBuild = config
    .build();

  return configBuild;
}

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.enableCors();
  const swaggerBuild = buildSwagger();

  const document = SwaggerModule.createDocument(app, swaggerBuild);
  SwaggerModule.setup('doc', app, document);

  await app.listen(parseInt(process.env.PORT) || 3000);
}
bootstrap();

