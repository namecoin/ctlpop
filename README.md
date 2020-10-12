# CTLPop

**We do these experiments so you don't have to. Do not try this at home. No really, don't.**

CTLPop ("Certificate Trust List Populator") is a PowerShell script that downloads all of the certificates from Windows's `authrootstl.cab` and imports all of them to the Windows certificate store.  It does not require any elevated privileges (e.g. write privileges to the `AuthRoot` cert store).  It is useful for situations where you want to execute operations on the `AuthRoot` cert store, and your code assumes that all certificates have already been populated there.

## Licence

Copyright (C) 2020 Namecoin Developers.

CTLPop is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

CTLPop is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with CTLPop.  If not, see [https://www.gnu.org/licenses/](https://www.gnu.org/licenses/).
