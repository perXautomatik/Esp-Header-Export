
Function Get-espHeader{
Param(
[Parameter(Mandatory=$true,
ValueFromPipeline=$true)] [String[]]$Process
)

(((-join (gc $Process | select -first 3)) -replace "[^\w. ]{1,}","�").split("�") -match "^.*[.](esp|esm)$").trim(' ')

}

#$MASTERLIST = gc "E:\Vortex Mods\falloutnv\CB-cell\"
#$MASTERLIST= "E:\SteamLibrary\steamapps\common\Fallout New Vegas\Data\FormiD.esp" | Get-espHeader | select -first 13
#$MASTERLIST= gc "C:\Users\chris\AppData\Local\FalloutNV\plugins.txt"
$MASTERLIST= gc "C:\Users\chris\AppData\Local\FalloutNV\plugins.txt"| select -first 13


#"E:\SteamLibrary\steamapps\common\Fallout New Vegas\Data\FormiD.esp" | Get-espHeader | ?{$MASTERLIST -NotContains $_}
$folderName = "E:\Vortex Mods\falloutnv\xEditFilterPatch"

#$filListToCheck = gc "C:\Users\chris\OneDrive\Desktop\FileList.txt"
$wildcards = @(".bak",".txt",".gitignore",".lnk")
$filListToCheck = Get-ChildItem -path $folderName | where {$_.extension -notin $wildcards}  | %{$_.fullname}

#get paths from filelist where Get-espHeader 

$filListToCheck | %{ 
    $path = $folder + $_;
    $path = $path + '.txt';
    $path;
    $_ | Get-espHeader| ?{$MASTERLIST -NotContains $_ }| Sort-Object Name | Out-File -Force $path;

     if($_ | Get-espHeader| ?{$MASTERLIST -NotContains $_}) {} #if there is unfulfilled dependencies, do nothing
     else {$_ }#else print path
 }


