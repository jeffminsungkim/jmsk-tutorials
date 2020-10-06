FROM node:12-alpine AS builder

WORKDIR /app/current

# /build contains tsconfig.json, package.json, lerna.json, yarn.lock and node_modules
COPY --from=pkg-builder /build/node_modules /app/current/packages/foo/node_modules
COPY --from=pkg-builder /build/tsconfig.json ./tsconfig.json

RUN echo $(ls -1 /app/current)

WORKDIR /app/current/packages/foo

COPY . .

RUN yarn build

# RUN yarn install --production

RUN echo $(ls -1 /app/current/packages/foo)

EXPOSE 8000

CMD [ "node", "./dist/main" ]
