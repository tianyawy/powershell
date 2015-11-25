$p = @("Start Install-NuPackage","End install.ps1");
Get-Content '.\New Text Document.txt' | Select-String -Pattern $p -SimpleMatch | Set-Content FilteredContent.txt;
import-csv  FilteredContent.txt -delimiter " "  -Header ConsoleTime,LogDateTime,Action,Command,Object  | export-csv csvfile.csv -NoTypeInformation;
$t = import-csv csvfile.csv | Group-Object {$_.Object}|Select-Object @{Name='Object'   ;Expression={$_.Group[1].Object }}, @{Name = 'startTime';Expression={$_.Group[0].ConsoleTime}}, @{Name = 'endTime';Expression={$_.Group[1].ConsoleTime}} |Select-object object,startTime,endTime 
$t = $t | Select-object object,startTime,endTime | Select-Object @{Name = 'object'; Expression = {$_.object}},@{Name = 'startTime';Expression={$_.startTime}}, @{Name = 'endTime';Expression={$_.endTime}},@{Name = 'diff';Expression={ [datetime]::ParseExact($_.startTime,"hh:mm:ss.fff",$null) - [datetime]::ParseExact($_.endTime,"hh:mm:ss.fff",$null)}}
$t | Select-object object,startTime,endTime,diff|export-csv result.csv -NoTypeInformation


