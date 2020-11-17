# Copyright 2020 Jeremy Rand.

# This file is part of CTLPop.
#
# CTLPop is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# CTLPop is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with CTLPop.  If not, see
# <https://www.gnu.org/licenses/>.

param (
  $sync_dir
)

# Measure initial count of certs
$initial_cert_count = (& certutil -store AuthRoot | Select-String -Pattern "=== Certificate \d+ ===" | Measure-Object -Line).Lines + (& certutil -store Root | Select-String -Pattern "=== Certificate \d+ ===" | Measure-Object -Line).Lines

Write-Host "Verifying cached registry AuthRootSTL"
& certutil -verifyCTL AuthRoot
$stage1_cert_count = (& certutil -store AuthRoot | Select-String -Pattern "=== Certificate \d+ ===" | Measure-Object -Line).Lines + (& certutil -store Root | Select-String -Pattern "=== Certificate \d+ ===" | Measure-Object -Line).Lines

Write-Host "Verifying updated registry AuthRootSTL"
& certutil -f -verifyCTL AuthRoot
$stage2_cert_count = (& certutil -store AuthRoot | Select-String -Pattern "=== Certificate \d+ ===" | Measure-Object -Line).Lines + (& certutil -store Root | Select-String -Pattern "=== Certificate \d+ ===" | Measure-Object -Line).Lines

Write-Host "Verifying CAB AuthRootSTL"
& certutil -verifyCTL AuthRootWU
$stage3_cert_count = (& certutil -store AuthRoot | Select-String -Pattern "=== Certificate \d+ ===" | Measure-Object -Line).Lines + (& certutil -store Root | Select-String -Pattern "=== Certificate \d+ ===" | Measure-Object -Line).Lines

Write-Host "Verifying Windows Update AuthRootSTL"
& certutil -f -verifyCTL AuthRootWU

# Measure final count of certs
$final_cert_count = (& certutil -store AuthRoot | Select-String -Pattern "=== Certificate \d+ ===" | Measure-Object -Line).Lines + (& certutil -store Root | Select-String -Pattern "=== Certificate \d+ ===" | Measure-Object -Line).Lines
$diff_cert_count = $final_cert_count - $initial_cert_count

Write-Host "----- Results -----"
Write-Host "----- Initial certs: $initial_cert_count -----"
Write-Host "----- Stage1 certs: $stage1_cert_count -----"
Write-Host "----- Stage2 certs: $stage2_cert_count -----"
Write-Host "----- Stage3 certs: $stage3_cert_count -----"
Write-Host "----- Final certs: $final_cert_count -----"
Write-Host "----- Diff (Final-Initial): $diff_cert_count -----"
