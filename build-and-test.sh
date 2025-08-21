#!/bin/bash

docker build -t oconnerj-github-io . && \
docker run --rm --network=host oconnerj-github-io