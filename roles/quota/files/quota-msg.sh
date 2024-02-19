if groups | grep -q jupyterhub-admins && quotaon -p -a | grep -v "project quota" | grep -q "is off"; then

cat << EOF
--------------------------------------------------------------------------------
WARNING!
$(quotaon -p -a | grep -v "project quota" | grep "is off")

  You may need to reboot the system to enable the quota kernel modules.
  ("sudo reboot")
--------------------------------------------------------------------------------

EOF
fi
