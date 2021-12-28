#current folder
$current = Get-Location
#$allfiles = Get-ChildItem -Path $current
#get files | Select-Object -Last 1

$bsarchPath="C:\Modding\Fallout4\fallout4\Tools\BSArch\bsarch.exe"

$esp = Get-ChildItem -Path $current | Where { $_.Name -like '*.esp'}
$esm = Get-ChildItem -Path $current | Where { $_.Name -like '*.esm'}

$espNr = ($esp).count
$esmNr = ($esm).count


$includedDirectory = "textures|meshes"
$textureMeshes = Get-ChildItem -Path $current -Directory | where Name -Match $includedDirectory

$includedDirectory = "music|sound"
$SoundMusic = Get-ChildItem -Path $current -Directory | where Name -Match $includedDirectory

$s = ""

if (($espNr -eq 1)-or ($esmNr -eq 1 )) {

    if ($espNr -eq 1) {
        $s = $esp | select -ExcludeProperty name | %{ [System.IO.Path]::GetFileNameWithoutExtension($_) -join [Environment]::NewLine}
    }

    if ($esmNr -eq 1) {
        #$s = $esm | %{$(select -property name) -join [Environment]::NewLine}
        $s  = $esm | select -ExcludeProperty name | %{ [System.IO.Path]::GetFileNameWithoutExtension($_) -join [Environment]::NewLine}
    }
}



#$s = if ($name -eq $null) { "no singular extension" } else { $name | Select-Object -Property name }
 # | Select-Object -ExpandProperty -Property -

 #for each folder
#if name textures
 #       meshes  then use x
if ($textureMeshes -ne $null)
{$textureMeshes | %{  ($_ | select -property name) | .$bsarchPath pack $_ ($s + " - " + $_ + ".bsa") -z -fnv -share -mt}}

#if name music
 #       sound then use y
 if ($SoundMusic -ne $null)
{
$SoundMusic | %{  ($_ | select -property name) | .$bsarchPath pack $_ ($s + " - " + $_ + ".bsa") -fnv -share -mt}}



#if other file or folder
 #   move to folder fomod

#end delete folders