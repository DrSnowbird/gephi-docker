FROM openkbs/jdk-mvn-py3-x11

MAINTAINER DrSnowbird "DrSnowbird@openkbs.org"

## ---- USER_NAME is defined in parent image: openkbs/jdk-mvn-py3-x11 already ----
ENV USER_NAME=${USER_NAME:-developer}
ENV HOME=/home/${USER_NAME}

#########################################################
#### ---- Build ARG and RUN ENV ----
#########################################################
ARG PRODUCT=${PRODUCT:-gephi}
ENV PRODUCT=gephi
ENV WORKSPACE=${HOME}/workspace

ARG PRODUCT_VERSION=${PRODUCT_VERSION:-0.9.2}
ENV PRODUCT_VERSION=${PRODUCT_VERSION}

ARG PRODUCT_DIR=${PRODUCT_DIR:-gephi_${PRODUCT_VERSION}}
ENV PRODUCT_DIR=${PRODUCT_DIR}

ARG PRODUCT_EXE=${PRODUCT_EXE:-bin/gephi}
ENV PRODUCT_EXE=${PRODUCT_EXE}

ARG INSTALL_BASE=${INSTALL_BASE:-/opt}
ENV INSTALL_BASE=${INSTALL_BASE}

####################################
#### ---- Install product: ---- ####
####################################
## --- Product Version specific ---

ENV DOWNLOAD_URL=https://github.com/gephi/gephi/releases/download/v${PRODUCT_VERSION}/gephi-${PRODUCT_VERSION}-linux.tar.gz

WORKDIR ${INSTALL_BASE}

#### ---- Install for application ----
RUN sudo wget -q -c ${DOWNLOAD_URL} && \
    sudo tar xvf $(basename ${DOWNLOAD_URL}) && \
    sudo rm $(basename ${DOWNLOAD_URL} )

#RUN echo "`pwd`" && \
#    wget https://github.com/gephi/gephi/releases/download/v${PRODUCT_VERSION}/gephi-${PRODUCT_VERSION}-linux.tar.gz && \
#    tar xzvf gephi-${PRODUCT_VERSION}-linux.tar.gz &&\
#    rm gephi-${PRODUCT_VERSION}-linux.tar.gz 
        
#########################################
#### ---- Addition Libs/Plugins ---- ####
#########################################
## -- hub.docker build having issue; temporarily remove these two lines --
#RUN sudo apt-get update -y && \
#    sudo apt-get install -y libwebkitgtk-3.0-0

VOLUME ${WORKSPACE}

#### ---- Environment for running application ----
USER ${USER_NAME}

ENV WORKSPACE=${HOME}/workspace

USER ${USER_NAME}

WORKDIR ${WORKSPACE}

#CMD "${INSTALL_BASE}/${PRODUCT_DIR}/${PRODUCT_EXE}"
CMD ["/opt/gephi-0.9.2/bin/gephi"]
#CMD "firefox"

