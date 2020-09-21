FROM node:12-alpine

WORKDIR /app/current

# /build contains tsconfig.json, package.json, lerna.json, yarn.lock and node_modules
COPY --from=pkg-builder /build ./

RUN echo $(ls -1 /app/current)

WORKDIR /app/current/packages/foo

COPY package.json tsconfig*.json ./

RUN yarn build

COPY dist ./dist

RUN echo $(ls -1 /app/current/packages/foo)

EXPOSE 8000

CMD [ "node", "./dist/main" ]
