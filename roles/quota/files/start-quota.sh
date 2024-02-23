#!/bin/bash -u
if [ "$EUID" -ne 0 ]; then
  echo "ERROR: please run as root"
  exit 1
fi

errcode=0

echo "---> Enabling quotas:"

mount -o remount -a || ((++errcode))
quotaoff -a        || ((++errcode))
quotacheck -acvugm || ((++errcode))
quotaon -avug      || ((++errcode))

if [ "$errcode" != 0 ]; then
  echo
  echo 'ERROR: You may need to reboot the system to load the quota kernel modules ("sudo reboot")'
  exit $errcode
else
  echo "<--- Finished enabling quotas"
fi

echo "---> Setting quotas for all jupyter-* users"
py=/opt/tljh/hub/bin/python
im="from tljh_custom_plugin import tljh_new_user_create as setquota"
for user in $(cut -d: -f1 /etc/passwd | grep jupyter-); do
  $py -c "$im; setquota('${user}')"
done
echo "<--- Finished setting quotas"
