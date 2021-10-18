$addonBuilderPath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\bohemia interactive\AddonBuilder').path
$addonBuilderExe = "$addonBuilderPath\AddonBuilder.exe"

Get-ChildItem .\addons -Directory | ForEach-Object {
  $addonFullPath = $_.FullName
  $addonOutputPath = "$(Get-Location)\addons"
  $pboPrefixFilename = "$addonFullPath\`$PBOPREFIX$"
  $includeFilename = "$addonFullPath\`$PBOINCLUDE$"
  $prefix = if(Test-Path $pboPrefixFilename) { "-prefix='$(Get-Content $pboPrefixFilename)'" }
  $include = if(Test-Path $includeFilename) { "-include=$includeFilename" }

  Write-Host
  Write-Host "--- Build addon ---"  
  Write-Host "AddonBuilder path : $addonBuilderPath"
  Write-Host "AddonBuilder exe  : $addonBuilderExe"
  Write-Host "Addon path : $addonFullPath"
  Write-Host "Output path : $addonOutputPath"
  Write-Host "Prefix : $prefix"
  Write-Host "Include : $include"

  & "$addonBuilderExe" "$addonFullPath" "$addonOutputPath" "$prefix" "$include"
}