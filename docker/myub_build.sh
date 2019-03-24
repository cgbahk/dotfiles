#!/bin/bash

BASEDIR=$(dirname "$0")
docker build -f ${BASEDIR}/myub-base.Dockerfile -t myub-base ${BASEDIR}
docker build -f ${BASEDIR}/myub.Dockerfile -t myub --no-cache ${BASEDIR}
