FROM python:3.6.4

MAINTAINER Luis Mayta <@slovacus>

ARG stage
ARG version

LABEL NAME pyworkplace-app-$stage
LABEL VERSION $version

COPY ./requirements/ /usr/src/requirements/
COPY ./requirements.txt /usr/src/requirements.txt

# set working directory to /usr/src/
WORKDIR /usr/src/

RUN pip install -r /usr/src/requirements/$stage.txt
