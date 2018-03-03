$Path = ".\Bin\NVIDIA-EWBF\\miner.exe"
$Uri = "https://github.com/Sniffdog/ewbf-miner-btg-edition/releases/download/v0.3.4b/ewbf-miner-btg.zip"

$Commands = [PSCustomObject]@{
    #"bitcore" = "" #Bitcore
    #"blake2s" = "" #Blake2s
    #"blakecoin" = "" #Blakecoin
    #"vanilla" = "" #BlakeVanilla
    #"cryptonight" = "" #Cryptonight
    #"decred" = "" #Decred
    "equihash" = '' #Equihash
    #"ethash" = "" #Ethash
    #"groestl" = "" #Groestl
    #"hmq1725" = "" #hmq1725
    #"keccak" = "" #Keccak
    #"lbry" = "" #Lbry
    #"lyra2v2" = "" #Lyra2RE2
    #"lyra2z" = "" #Lyra2z
    #"myr-gr" = "" #MyriadGroestl
    #"neoscrypt" = "" #NeoScrypt
    #"nist5" = "" #Nist5
    #"pascal" = "" #Pascal
    #"qubit" = "" #Qubit
    #"scrypt" = "" #Scrypt
    #"sia" = "" #Sia
    #"sib" = "" #Sib
    #"skein" = "" #Skein
    #"timetravel" = "" #Timetravel
    #"x11" = "" #X11
    #"x11evo" = "" #X11evo
    #"x17" = "" #X17
    #"yescrypt" = "" #Yescrypt
}

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Commands | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = "NVIDIA"
        Path = $Path
        Arguments = "--api --server $($Pools.', $_, '.Host) --port $($Pools.', $_, '.Port) --fee 0 --solver 0 --eexit 1 --user $($Pools.', $_, '.User) --pass $($Pools.', $_, '.Pass)$($Commands.$_)"
        HashRates = [PSCustomObject]@{', $_, ' = $Stats."$($Name)_$', $_, '_HashRate".Day}
        API = "EWBF"
        Port = 42000
        Wrap = $false
        URI = $Uri
    }
}
