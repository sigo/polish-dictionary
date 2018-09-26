FROM alpine
RUN apk add aspell aspell-utils make
WORKDIR /code/
COPY ./scripts/utils.sh ./scripts/build.sh ./
CMD ./build.sh
