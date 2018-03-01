$Path = ".\Bin\bitcore-spmod2\bitcore-spmod2.exe" 
#$Uri = "" 


$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Algorithms = [PSCustomObject]@{
    
    Bitcore = 'bitcore'

    
}

$Optimizations = [PSCustomObject]@{
    Lyra2z = ''
    Equihash = ''
    Cryptonight = ''
    Ethash = ''
    Sia = ''
    Yescrypt = ''
    BlakeVanilla = ''
    Lyra2RE2 = ' -i 20 --api-remote'
    Skein = ' -i 28 --api-remote'
    Qubit = ''
    NeoScrypt = ' -i 15 --api-remote'
    X11 = ' -i 21 --api-remote'
    MyriadGroestl = ' --api-remote'
    Groestl = ''
    Keccak = ' --api-remote'
    Scrypt = ''
    Bitcore = ' -i 18,16,16,16,16'
    Blake2s = ' --api-remote'
    Sib = ' -i 21 --api-remote'
    X17 = ' -i 21.5 --api-remote'
    Quark = ''
    Hmq1725 = ''
    Veltor = ' --api-remote'
    X11evo = ' -i 21 --api-remote'
    Timetravel = ' -i 25 --api-remote'
    Blakecoin = ' --api-remote'
    Lbry = ' -i 28 --api-remote'
    C11 = ' -i 20 --api-remote'
    Nist5 = ' -i 20 --api-remote'
}

$Algorithms | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = 'NVIDIA'
        Path = $Path
        Arguments = -Join ('-a ', $Algorithms.$_, ' -o stratum+tcp://$($Pools.', $_, '.Host):$($Pools.', $_, '.Port) -u $($Pools.', $_, '.User).ZcodeMiner -p $($Pools.', $_, '.Pass)', $Optimizations.$_)
        HashRates = [PSCustomObject]@{$_ = -Join ('$($Stats.', $Name, '_', $_, '_HashRate.Day)')}
        API = 'Ccminer'
        Port = 4068
        Wrap = $false
        URI = $Uri
    }
}
