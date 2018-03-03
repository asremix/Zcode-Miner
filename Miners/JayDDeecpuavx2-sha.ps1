﻿$Path = ".\Bin\CPU-JayDDee\cpuminer-avx2-sha.exe"
$Uri = "https://github.com/JayDDee/cpuminer-opt/files/1734002/cpuminer-opt-3.8.2.1-windows.zip"

$Commands = [PSCustomObject]@{
    #"lyra2z" = "" #Difficulty might be ignored - more testing needed.
    #"cryptonight" = " -t 16 --cpu-affinity 0x5555" #Threadripper 1950X
    #"timetravel" = ",d=0.5"
    #"x17" = ""  #needs a very fast CPU, so may not be practical to enable by default
    #"bitcore" = ",d=0.02"
    #"xevan" = ""
    #"x11evo" = "" #needs a very fast CPU, so may not be practical to enable by default
    #"yescrypt" = "" #Yescrypt
    #"m7m" = "" #M7M
    #"lyra2h" = "" #Lyra2h
    #"yescryptr8" = "" #Yescryptr8
    #"x16r" = "" #Ravencoin
    #"yescryptr16" = "" #Yenten Zergpool

}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name | ForEach-Object {
    [PSCustomObject]@{
        Type = "CPU"
        Path = $Path
        Arguments = "-a $_ -o stratum+tcp://$($Pools.', $_, '.Host):$($Pools.', $_, '.Port) -u $($Pools.', $_, '.User) -p $($Pools.', $_, '.Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{', $_, ' = $Stats."$($Name)_$', $_, '_HashRate".Day}
        API = "Ccminer"
        Port = 4048
        Wrap = $false
        URI = $Uri
    }
}
