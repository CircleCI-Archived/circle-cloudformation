#! /bin/bash

set -exu

ARTIFACT_ROOT=https://circle-artifacts.com/gh/circleci/circle-cloudformation
ARTIFACT_FILE=$(find $CIRCLE_ARTIFACTS -name *-jar-with-dependencies.jar)
ARTIFACT_URL=$ARTIFACT_ROOT/$CIRCLE_BUILD_NUM/artifacts/0$ARTIFACT_FILE

aws cloudformation create-stack \
          --stack-name circle-cloudformation-$CIRCLE_BUILD_NUM \
          --template-body template.json \
          
