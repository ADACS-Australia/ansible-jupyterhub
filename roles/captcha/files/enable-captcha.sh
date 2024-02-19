#!/bin/bash -eu

if [ "$EUID" -ne 0 ]; then
  echo "ERROR: please run as root"
  exit 1
fi

if [ "$#" -ne 2 ]; then
  echo "Usage:"
  echo "  enable-captcha <key> <secret>"
  echo
  echo "If you don't have a key+secret, go to www.google.com/recaptcha/ and set them up."
  exit 1
fi

RECAPTCHA_KEY="$1"
RECAPTCHA_SECRET="$2"

tljh-config set auth.NativeAuthenticator.recaptcha_key "${RECAPTCHA_KEY}"
tljh-config set auth.NativeAuthenticator.recaptcha_secret "${RECAPTCHA_SECRET}"
tljh-config reload
