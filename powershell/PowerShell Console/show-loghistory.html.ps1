. "$env:PSConsole\powershell\WebUtil.ps1"

write-in @"
{
    "numDaysOld": 1
}
"@

# This script requires that a virtual directory named common has been created in the PSWeb that points to the PSWebShare location.

$outString = "" 
Get-ChildItem -Path "$env:PSConsole\logs" |
    ? { $_.LastWriteTime -gt (Get-Date).AddDays(-$numDaysOld) } |
    sort LastWriteTime -Descending |
    % {
        $outString += "<span>" + $_.LastWriteTime + "</span> - <a target='_blank' href='./common/logs/" + $_.Name + "'>" + $_.Name + "</a><br/>" 
    }

write-out $outString "history"