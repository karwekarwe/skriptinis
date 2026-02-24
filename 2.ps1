param(
  [string]$Username
)




$p = @(Get-Process -IncludeUserName) #visi procesai
$aplankas = "C:\Users\domas\Desktop\test2"

$groups = $p | Group-Object -Property UserName

if ($Username) {
  $short = ($Username -split '\\')[-1]
  $groups = $groups | Where-Object {
    $_.Name -and ( $_.Name -eq $Username -or $_.Name -like "*\$short" -or $_.Name -eq $short )
  }
}

$date = Get-Date -Format "yyyy-MM-dd"
$time = Get-Date -Format "HH-mm"


foreach ($group in $groups) {

  $name = $group.Name.Replace('\', '_').Replace(' ', '-')
  if ($name -eq '') {
    $name = "be_pavadinimo"
  }
  $log = Join-Path $aplankas -ChildPath ("$name-process-log-$date-$time.txt")

  $lines = @()
  $lines += "current date: $date"
  $lines += "current time: $time"
  $lines += ""


  foreach ($process in $group.Group){
    $lines += "process name: $($process.ProcessName)"
    $lines += "process pid: $($process.Id)"
    $lines += "process cpu: $($process.CPU)"
    $lines += "process handles: $($process.Handles)"
    $lines += ""
  }

  Set-Content -Path $log -Value $lines
}

$allFiles = Get-ChildItem -Path $aplankas

foreach ($file in $allFiles) {
  Start-Process -FilePath notepad.exe -ArgumentList "$aplankas\$($file.Name)"
}

write-host "Press any key to continue..."
[void][System.Console]::ReadKey($true)

Get-Process notepad -ErrorAction SilentlyContinue | Stop-Process -Force

foreach ($file in $allFiles) {
  Remove-Item "$aplankas\$file"
}




#C:\Users\domas\Desktop\test2

#./2.ps1


