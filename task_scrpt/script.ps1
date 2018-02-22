function global:install-git {
  foreach($url in $giturl,$noteplusurl) {
    Write-Output "Using Install Url : $url`r`n"
    install-file $url
  }
}

function global:install-file([string] $urlPath) {
  $filename = download-file($urlPath)
  Write-Output "Installing : $filename`r`n"
  invoke-item $filename
}

function global:download-file([string] $urlPath) {
  $urlSplit = $urlPath.split('/')
  $filename = (Resolve-Path .).ToString() + '\' + $urlSplit[$urlSplit.length - 1]
  $webclient = New-Object "System.Net.WebClient"
  $webclient.DownloadFile($urlPath, $filename)
  return $filename
}

function Get-GitClone{
   
   # Create temp folder
   mkdir $gitpath -force
   cd $gitpath
   

   # Clone TFD Git repository
   git-bash.exe -c "git clone $cloneUrl"
}

$driveletter=$args[0]
$path=$args[1]
$persistent="no"
$giturl=$args[2]
$noteplusurl=$args[3]
$cloneUrl=$args[4]
$gitpath=$args[5]

Get-Service aspnet_state | Where {$_.status -eq 'stopped'} | Start-Service
Set-Service aspnet_state -StartupType Automatic
Get-Service aspnet_state | Select-Object *
Write-Output "Local Drive used : $driveletter`r`n"
Write-Output "Network Share : $path`r`n"

<# Mount the Share #>

$nwrk=new-object -com Wscript.Network
          Write-Output "Mapping $($driveletter+':') to $path and persist=$persistent`r`n"
          try{
               $nwrk.MapNetworkDrive($($driveletter+':'),$path)     
               Write-Output "Mapping successful.`r`n"
          }
          catch{
               Write-Output "Mapping failed!`r`n"
          }

install-git
setx PATH "$env:path;C:\Program Files\Git" -m
Get-GitClone