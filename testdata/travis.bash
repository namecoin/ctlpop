#!/bin/bash
set -euxo pipefail
shopt -s nullglob globstar

# Wipe the authroot.stl so that it gets refreshed.
#powershell -command 'Remove-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\SystemCertificates\AuthRoot\AutoUpdate -Name LastSyncTime'

mkdir sync1
powershell -ExecutionPolicy Unrestricted -File "ctlpop.ps1" "-sync_dir" "sync1" | tee run1.log

if grep "Diff (Final-Initial): 0" run1.log; then
  echo "Initial test failed; no certs were added."
  exit 1
else
  echo "Initial test passed; certs were added."
fi

mkdir sync2
powershell -ExecutionPolicy Unrestricted -File "ctlpop.ps1" "-sync_dir" "sync2" | tee run2.log

if grep "Diff (Final-Initial): 0" run2.log; then
  echo "Repeat test passed; no certs were missed the first time."
else
  echo "Repeat test failed; certs were missed the first time."
  exit 1
fi
