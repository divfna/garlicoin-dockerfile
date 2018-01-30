FROM debian:jessie-slim
LABEL maintainer="Erik Rogers <erik.rogers@live.com>"

ENV DEBIAN_FRONTEND noninteractive

ENV GARLICOIN_VERSION 0.16.0
ENV GARLICOIN_PACKAGE Garlicoin
ENV GARLICOIN_ARCHIVE ${GARLICOIN_PACKAGE}-x86_64-unknown-linux-gnu.tar.gz

ENV GARLICOIN_RELEASE https://github.com/GarlicoinOrg/Garlicoin/releases/download/20180123154915-i686-pc-linux-gnu/${GARLICOIN_ARCHIVE}

ENV GARLICOIN_DIR /opt/${GARLICOIN_PACKAGE}

# Install dependencies
WORKDIR /tmp
RUN apt-get update && apt-get install -y --no-install-recommends \
  wget \
  ca-certificates \
  && rm -rf /var/cache/apk/*

# Download and install Garlicoin release
RUN wget ${GARLICOIN_RELEASE} \
  && mkdir -p ${GARLICOIN_PACKAGE} \
  && tar xvf ${GARLICOIN_ARCHIVE} --strip-components=1 -C ${GARLICOIN_PACKAGE} \
  && mkdir -p ${GARLICOIN_DIR} \
  && cp -r ${GARLICOIN_PACKAGE}/bin ${GARLICOIN_DIR} \
  && rm -rf ${GARLICOIN_PACKAGE} \
  && rm ${GARLICOIN_ARCHIVE}

# Add to PATH
ENV PATH $GARLICOIN_DIR/bin:$PATH

# Copy example config
ENV GARLICOIN_DATA_DIR /data/garlicoin
RUN mkdir -p ${GARLICOIN_DATA_DIR}
COPY garlicoin.conf ${GARLICOIN_DATA_DIR}
VOLUME ${GARLICOIN_DATA_DIR}

# Copy shell script and make executable
COPY *.sh $GARLICOIN_DIR
WORKDIR ${GARLICOIN_DIR}
RUN chmod +x *.sh

# Start Garlicoin daemon
ENTRYPOINT ["./start_garlicoin.sh"]

