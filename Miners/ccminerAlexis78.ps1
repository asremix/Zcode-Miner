$Path = ".\Bin\NVIDIA-Alexis78\ccminer.exe"
$Uri = "https://github.com/nemosminer/ccminerAlexis78/releases/download/3%2F3%2F2018/ccminer-Alexis78.zip"

$Algorithms = [PSCustomObject]@{
	Hsr = 'hsr' #Hsr
    Blake2s = 'blake2s' #Blake2s
    Veltor = 'veltor' #Veltor
    Keccak = 'keccak' #Keccak
    Lbry = 'lbry' #Lbry
    Lyra2RE2 = 'lyra2RE2' #Lyra2RE2
    Nist5 = 'nist5' #Nist5
    Sib = 'sib' #Sib
    Skein = 'skein' #Skein
    C11 = 'c11' #C11
    X17 = 'x17' #X17
}
$Optimizations = [PSCustomObject]@{
	Hsr = ' --api-remote' #Hsr
    Blake2s = ' --api-remote' #Blake2s
    Veltor = ' -i 20 --api-remote' #Veltor
    Keccak = ' -m 2 -i 21 ' #Keccak
    Lbry = ' --api-remote' #Lbry
    Lyra2RE2 = ' --api-remote' #Lyra2RE2
    Nist5 = ' --api-remote' #Nist5
    Sib = ' -i 21 --api-remote' #Sib
    Skein = ' --api-remote' #Skein
    C11 = ' -i 21 --api-remote' #C11
    X17 = ' -i 20 --api-remote' #X17
}

$Algorithms | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = 'NVIDIA'
        Path = $Path
        Arguments = -Join ('-a ', $Algorithms.$_, ' -o stratum+tcp://$($Pools.', $_, '.Host):$($Pools.', $_, '.Port) -u $($Pools.', $_, '.User) -p $($Pools.', $_, '.Pass)', $Optimizations.$_, ' -R 10 -T 30')
        HashRates = [PSCustomObject]@{$_ = -Join ('$($Stats.', $Name, '_', $_, '_HashRate.Day)')}
        API = 'Ccminer'
        Port = 4068
        Wrap = $false
        URI = $Uri
    }
}
