. .\Include.ps1

$Path = ".\Bin\Lyra2z-AMD\sgminer.exe"
$Uri = "https://github.com/djm34/sgminer-msvc2015/releases/download/v0.3/kernel.rar"

$Commands = [PSCustomObject]@{
    "lyra2z" = " --worksize 32 --intensity 18" #Lyra2z
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
