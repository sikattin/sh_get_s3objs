#!/bin/bash

### get_s3obj.sh ###
# awscli wrapper script of s3 copy.
#   requirements:
#     - awscli
#   ENVIRONMENT VARS:
#     OAWSCLI: awscli executable path
#     OSAVEPATH: save path of copied S3 object
# 
###

BUCKET="<bucket name>"
AWSCLI="/usr/bin/aws"
SAVEPATH="/savepath"

if [[ $# -lt 2 ]]; then
    cat << EOL
Usage: get_s3obj.sh [<PREFIX>] [<OBJECT_KEY>]

positional arguments:
  <PREFIX>        prefix of object key
                  following X values available
                  aaa, bbb, ccc
  <OBJECT_KEY>    key name of the object which you want to get
  
Example:
  Get S3://BUCKET/aaa/testfile
  # get_s3obj.sh aaa testfile
  
  Get S3://BUCKET/bbb/testfile
  # get_s3obj.sh bbb testfile
EOL
    exit 2
fi

if [[ ! ($1 =~ aaa|bbb|ccc) ]];then
    echo "first positional argument <PREFIX> must be the one of following X values" 1>&2
    echo "aaa, bbb, ccc" 1>&2
    exit 2
fi


prefix=$1
keyname=$2
awscli=${AWSCLI}
bucket=${BUCKET}
save_path=${SAVEPATH}

# override if environment variables be passed
if [[ ${OAWSCLI} ]]; then
    awscli=${OAWSCLI}
fi
if [[ ${OSAVEPATH }]]; then
    save_path=${OSAVEPATH}
fi


${awscli} s3 cp s3://${bucket}/${prefix}/${keyname} ${save_path}