#! /bin/bash

set -exu

ARTIFACT_ROOT=https://circle-artifacts.com/gh/circleci/circle-cloudformation
ARTIFACT_FILE=$(find $CIRCLE_ARTIFACTS -name *-jar-with-dependencies.jar)
ARTIFACT_URL=$ARTIFACT_ROOT/$CIRCLE_BUILD_NUM/artifacts/0$ARTIFACT_FILE

aws cloudformation create-stack \
          --stack-name circle-cloudformation-$CIRCLE_BUILD_NUM \
          --use-previous-template \
          --parameters \
            ParameterKey=ArtifactUrl,ParameterValue=$ARTIFACT_URL \
            ParameterKey=AMI,UsePreviousValue=true \
            ParameterKey=SecurityGroup,UsePreviousValue=true \
            ParameterKey=CircleToken,UsePreviousValue=true \
            ParameterKey=KeyName,UsePreviousValue=true \
