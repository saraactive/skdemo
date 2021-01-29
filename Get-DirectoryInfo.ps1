function Get-FolderSize
{
    [cmdletbinding()]
Param(
[Parameter(Position=0)]
[ValidateScript({Test-Path $_})]
[string]$Path=".",
[switch]$Force
)

Write-Verbose "Starting $($myinvocation.MyCommand)"
Write-Verbose "Analyzing $path"

#define a hashtable of parameters to splat to Get-ChildItem
$dirParams = @{
Path = $Path
ErrorAction = "Stop"
ErrorVariable = "myErr"
Directory = $True
}

if ($Force) {
    $dirParams.Add("Force",$True)
}
$activity = $myinvocation.MyCommand

#Write-Progress -Activity $activity -Status "Getting top level folders" -CurrentOperation $Path

$folders = Get-ChildItem @dirParams

#process each folder
$folders | 
foreach -begin {
     #Write-Verbose $Path
     #initialize some total counters
     $totalFiles = 0
     $totalSize = 0
     #initialize a counter for progress bar
     $i=0

     Try {     
        #measure files in $Path root
        #Write-Progress -Activity $activity -Status $Path -CurrentOperation "Measuring root folder" -PercentComplete 0
        #modify dirParams hashtable
        $dirParams.Remove("Directory")
        $dirParams.Add("File",$True)
        $stats = Get-ChildItem @dirParams | Measure-Object -Property length -sum
     }
     Catch {
        $msg = "Error: $($myErr[0].ErrorRecord.CategoryInfo.Category) $($myErr[0].ErrorRecord.CategoryInfo.TargetName)"
        Write-Warning $msg
     }
     #increment the grand totals
     $totalFiles+= $stats.Count
     $totalSize+= $stats.sum

     if ($stats.count -eq 0) {
        #set size to 0 if the top level folder is empty
        $size = 0
     }
     else {
        $size=$stats.sum
     }

     if($Force)
     {
        $root = Get-Item $path -Force
        $hash = [ordered]@{
         Path = $root.FullName
         Name = $root.Name
         Size = $size/1MB
         Count = $stats.count
         Attributes = (Get-Item $path -Force).Attributes}
     }
     else
     {
        $root = Get-Item $path
        $hash = [ordered]@{
        Path = $root.FullName
        Name = $root.Name
        Size = $size/1MB
        Count = $stats.count
        Attributes = (Get-Item $path).Attributes}
     }
     #write the object for the folder root
     New-Object -TypeName PSobject -Property $hash

    } -process { 
     Try {
        #Write-Verbose $_.fullname
        $i++
        [int]$percomplete = ($i/$folders.count)*100
        #Write-Progress -Activity $activity -Status $_.fullname -CurrentOperation "Measuring folder" -PercentComplete $percomplete

        #get directory information for top level folders
        $dirParams.Path = $_.Fullname
        $stats = Get-ChildItem @dirParams -Recurse | Measure-Object -Property length -sum
     }
     Catch {
        $msg = "Error: $($myErr[0].ErrorRecord.CategoryInfo.Category) $($myErr[0].ErrorRecord.CategoryInfo.TargetName)"
        Write-Warning $msg
     }
     #increment the grand totals
     $totalFiles+= $stats.Count
     $totalSize+= $stats.sum

     if ($stats.count -eq 0) {
        #set size to 0 if the top level folder is empty
       $size = 0
     }
     else {
        $size=$stats.sum
     }
     #define properties for the custom object
     $hash = [ordered]@{
         Path = $_.FullName
         Name = $_.Name
         Size = $size/1Mb
         Count = $stats.count
         Attributes = $_.Attributes
        }
     #write the object for each top level folder
     New-Object -TypeName PSobject -Property $hash
 } -end {
    #Write-Progress -Activity $activity -Status "Finished" -Completed
    #Write-Verbose "Total number of files for $path = $totalfiles"
    #Write-Verbose "Total file size in bytes for $path = $totalsize"
 }

 #Write-Verbose "Ending $($myinvocation.MyCommand)"
 } #end Get-FolderSize

$ResolvedPath = "C:\`$Recycle.Bin"

$FoldSize = ((Get-FolderSize -Path $ResolvedPath -Force | Measure-Object -Property Size -Sum).Sum).ToString() + " MB"
$FoldSize