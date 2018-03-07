$Path = ".\Bin\NVIDIA-CcminerAlexiskeccakc\ccminer_CP.exe"
$Uri = "https://github.com/cornz/ccminer/releases/download/keccakc/ccminer_CP.zip"

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Algorithms = [PSCustomObject]@{
    
		Keccakc = 'keccakc'  #Keccakc
    
}
$Optimizations = [PSCustomObject]@{

		keccakc = ' --api-remote' #Keccakc

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