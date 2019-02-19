#!/usr/bin/env bash

# motivation:
# when CA infra-ssh fails, this tool can help to troubleshoot 

# //// troubleshoot public key denied problem (jump host) ////

# this script creates the Linux user on the host VM

# /Users/weining/work/canva/infrastructure/common/jump/image/opt/iam/import_users.sh
# get_iam_users() {
#   local group
#   group="${1}"

#   local extra_args=()
#   if [[ "${SYNC_FROM_IDENTITY}" == "true" ]]; then
#     extra_args+=( --region "${REGION}" )
#   fi

#   aws iam get-group \
#       --group-name "${group}" \
#       --query "Users[].[UserName]" \
#       --output text \
#       "${extra_args[@]:-}" \
#       | sed "s/\\r//g"
# }

# the user must be in an IAM group 
# to verify the user's creation, see linuxAdmin/users/find_user_creation_time.sh

# 

