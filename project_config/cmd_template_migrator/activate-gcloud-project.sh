#!/usr/bin/env sh
set -e
gcloud auth activate-service-account $AUTH_ACCOUNT --key-file=$GOOGLE_APPLICATION_CREDENTIALS;
gcloud config set project $PROJECT_ID;
