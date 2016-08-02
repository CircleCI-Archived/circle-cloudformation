#! /bin/bash

set -exu

ARTIFACT_ROOT=https://circle-artifacts.com/gh/circleci/circle-cloudformation
ARTIFACT_FILE=$(find $CIRCLE_ARTIFACTS -name *-jar-with-dependencies.jar)
ARTIFACT_URL=$ARTIFACT_ROOT/$CIRCLE_BUILD_NUM/artifacts/0$ARTIFACT_FILE
STACK_NAME=circle-cloudformation-$CIRCLE_BUILD_NUM
_
aws cloudformation create-stack \
          --stack-name $STACK_NAME \
          --template-body file://template.json \
          
aws cloudformation wait stack-create-complete --stack-name $STACK_NAME
          
