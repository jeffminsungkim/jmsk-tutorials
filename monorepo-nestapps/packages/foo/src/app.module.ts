import { Module } from "@nestjs/common";
import { TypeOrmModule } from "@nestjs/typeorm";
import { AppController } from "./app.controller";
import { UserModule } from "./user/user.module";
import { User } from "./user/user.entity";

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: "mariadb",
      host: "mariadb",
      port: 3306,
      username: "root",
      password: "root",
      database: "tutorial",
      entities: [User],
      synchronize: true,
      retryAttempts: 2,
      retryDelay: 1000,
    }),
    UserModule,
  ],
  controllers: [AppController],
})
export class AppModule {}
