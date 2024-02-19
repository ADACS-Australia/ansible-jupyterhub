if groups | grep -q jupyterhub-admins && ! sudo tljh-config show | grep -q "recaptcha" ; then

cat << EOF

--------------------------------------------------------------------------------
WARNING!
  You don't have reCaptcha enabled on this server, which means it is prone to
  scripted SignUp attacks.
  Please go to www.google.com/recaptcha/ to set up a reCaptcha, and then run:
    sudo enable-captcha <key> <secret>
--------------------------------------------------------------------------------

EOF
fi
