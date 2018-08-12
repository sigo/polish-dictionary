FROM alpine
RUN apk add aspell aspell-utils make
WORKDIR /code/
COPY build.sh .
CMD ./build.sh
