FROM ubuntu:20.04

ENV DEPENDENCIES="jq git-core python3 python3-pip python-is-python3 wget unzip curl"

RUN apt update && apt -y upgrade && apt -y install ${DEPENDENCIES} && pip install --upgrade pip