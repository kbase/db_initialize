# Simple image for initializing mongodb and mysql databases
FROM kbase/kb_minideb:stretch

ARG BUILD_DATE
ARG VCS_REF
ARG GO_VER=1.5.4
ARG BRANCH=develop

RUN apt-get update && \
    apt-get -y install mongodb-clients mysql-client netcat-openbsd

# This build of shock seems to malfunction if we go above Go 1.5

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/kbase/db_initialize.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1" \
      us.kbase.go-version=$GO_VER \
      us.kbase.vcs-branch=$BRANCH \
      maintainer="Steve Chan sychan@lbl.gov"


