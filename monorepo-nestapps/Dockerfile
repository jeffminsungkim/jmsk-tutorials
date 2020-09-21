FROM node:12-alpine

COPY --from=pkg-builder /build /build

WORKDIR /build

# RUN apk --no-cache add --virtual builds-deps build-base python

RUN rm -rf node_modules
RUN yarn
RUN echo $(ls -1 /build)

CMD ["true"]