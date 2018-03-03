﻿. .\Include.ps1

$Path = ".\Bin\NeoScrypt-AMD\nsgminer.exe"
$Uri = "https://github.com/ghostlander/nsgminer/releases/download/nsgminer-v0.9.3/nsgminer-win64-0.9.3.zip"

$Commands = [PSCustomObject]@{
    "neoscrypt" = " --gpu-threads 1 --worksize 64 --intensity 11 --thread-concurrency 64" #NeoScrypt
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object {
    [PSCustomObject]@{
        Type = "AMD"
        Path = $Path
        Arguments = "--api-listen --$_ -o stratum+tcp://$($Pools.', $_, '.Host):$($Pools.', $_, '.Port) -u $($Pools.', $_, '.User) -p $($Pools.', $_, '.Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{', $_, ' = $Stats."$($Name)_$', $_, '_HashRate".Week}
        API = "Xgminer"
        Port = 4028
        Wrap = $false
        URI = $Uri
    }
}
