# Alpine is used for small size and security
FROM alpine

# Install required packages
#
# All packages are used in `scripts/dictionary_build.sh` or by commands executed in this file
# aspell: Required as spell-checking and dictionary dumping engine
# aspell-utils: Required aspell's `prezip-bin` util by dictionary install process
# make: Required during install dictionary process
RUN apk --no-cache add aspell aspell-utils make

# Set working directory
WORKDIR /code/

# Copy dictionary builder and utils scripts
COPY ./scripts/utils.sh ./scripts/dictionary_build.sh ./

# Run dictionary builder
CMD ./dictionary_build.sh
