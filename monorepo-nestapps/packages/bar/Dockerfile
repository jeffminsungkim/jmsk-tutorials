FROM node:12-alpine

WORKDIR /app/current

# /build contains tsconfig.json, package.json, lerna.json, yarn.lock and node_modules
COPY --from=pkg-builder /build ./

RUN echo $(ls -1 /app/current)

WORKDIR /app/current/packages/bar

COPY . .

RUN yarn build

EXPOSE 8002

CMD [ "node", "./dist/main" ]
