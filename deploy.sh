#! /bin/bash

set -exu

ARTIFACT_ROOT=https://circle-artifacts.com/gh/circleci/circle-cloudformation
ARTIFACT_FILE=$(find $CIRCLE_ARTIFACTS -name *-jar-with-dependencies.jar)
ARTIFACT_URL=$ARTIFACT_ROOT/$CIRCLE_BUILD_NUM/artifacts/0$ARTIFACT_FILE
STACK_NAME=circle-cloudformation-$CIRCLE_BUILD_NUM

function waitOnCompletion() {
    STATUS=IN_PROGRESS
    while expr "$STATUS" : '^.*PROGRESS' > /dev/null ; do
        sleep 10
        STATUS=$(aws cloudformation describe-stacks --stack-name $STACK_NAME | jq -r '.Stacks[0].StackStatus')
        echo $STATUS
    done
}

aws cloudformation create-stack \
          --stack-name $STACK_NAME \
          --template-body file://template.json \
          --parameters ParameterKey=KeyName,ParameterValue=vpc-reference \
          
          
waitOnCompletion
          
