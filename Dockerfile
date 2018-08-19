FROM alpine
RUN apk add aspell aspell-utils make
WORKDIR /code/
COPY ./scripts/build.sh .
CMD ./build.sh
