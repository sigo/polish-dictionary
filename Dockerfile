FROM alpine
RUN apk add aspell aspell-utils make
WORKDIR /code/
COPY ./scripts/build.sh ./scripts/stats.sh ./
CMD ./build.sh && ./stats.sh
