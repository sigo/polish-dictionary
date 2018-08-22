FROM alpine
RUN apk add aspell aspell-utils make
WORKDIR /code/
COPY ./scripts/build.sh ./scripts/utils.sh ./
CMD ./build.sh
