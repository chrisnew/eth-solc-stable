FROM alpine:3.6

WORKDIR /solidity

COPY /solidity /solidity

RUN ./scripts/install_deps.sh && sed -i -E -e 's/include <sys\/poll.h>/include <poll.h>/' /usr/include/boost/asio/detail/socket_types.hpp && \
  cmake -DCMAKE_BUILD_TYPE=Release -DTESTS=0 -DSTATIC_LINKING=1 && \
  make solc && install -s  solc/solc /usr/bin && \
  cd / && rm -rf solidity && \
  apk del sed build-base git make cmake gcc g++ musl-dev curl-dev boost-dev && \
  rm -rf /var/cache/apk/*


