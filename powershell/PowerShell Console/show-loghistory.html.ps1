. "$env:PSConsole\powershell\WebUtil.ps1"

# numDaysOld IS AN INTEGER OF HOW MANY DAYS TO DISPLAY
write-in @"
{
    "numDaysOld": 1
}
"@

# THIS SCRIPT REQUIES THAT A VIRTUAL DIRECTORY NAMED COMMON HAS BEEN CREATED IN PSWEB THAT MAPS TO THE PSWEBSHARE LOCATION.
# THE HREF REFERENCE TO THE LOG FILE CAN THEN BE SERVERED BY PSWEB
# OPTIONALLY YOU COULD MAKE THE PSWEBSHARE DIRECTORY A WEB APPLICATION ITSELF AND CHANGE THE HREF TO POINT TO THE LOG LOCATIONS OF THAT WEB APPLICATION

# NOTICE THE USE OF $env:PSConsole THIS VARIABLE IS REPLACED BY PSWEB TO THE ACTUAL PSWEBSHARE LOCATION AT RUNTIME

$global:outString = "" 
Get-ChildItem -Path "$env:PSConsole\logs" | 
    Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-$numDaysOld) } |
    Sort-Object LastWriteTime -Descending |
    Select-Object {
        $global:outString += "<span>" + $_.LastWriteTime + "</span> - <a target='_blank' href='./common/logs/" + $_.Name + "'>" + $_.Name + "</a><br/>" 
    }

write-out $global:outString "history"