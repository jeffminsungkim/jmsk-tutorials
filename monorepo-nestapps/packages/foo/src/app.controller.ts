import { Controller, Get } from "@nestjs/common";
import { randomStringGenerator } from "@nestjs/common/utils/random-string-generator.util";
import _ from "lodash";

@Controller()
export class AppController {
  @Get()
  getHello() {
    return `Hello Foo ${randomStringGenerator()}`;
  }

  @Get("/chunk")
  getChunkedValues() {
    return _.chunk(["a", "b", "c", "d"], 2);
  }
}
