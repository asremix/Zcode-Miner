﻿. .\Include.ps1

$Path = ".\Bin\Skein-AMD\sgminer.exe"
$Uri = "https://github.com/miningpoolhub/sgminer/releases/download/5.3.1/Release.zip"

$Commands = [PSCustomObject]@{
    "skeincoin" = " --gpu-threads 2 --worksize 256 --intensity d" #Skein
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object {
    [PSCustomObject]@{
        Type = "AMD"
        Path = $Path
        Arguments = "--api-listen -k $_ -o $($Pools.', $_, '.Protocol)://$($Pools.', $_, '.Host):$($Pools.', $_, '.Port) -u $($Pools.', $_, '.User) -p $($Pools.', $_, '.Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{', $_, ' = $Stats."$($Name)_$', $_, '_HashRate".Week}
        API = "Xgminer"
        Port = 4028
        Wrap = $false
        URI = $Uri
    }
}