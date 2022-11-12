##########################################################################################################################################
# Name: Check Windows License Status
# Author: Aaron Templin / beholdTHEstove -Github
# Version: 1.0
# Edited: 
# 
# Note: Script to check Windows licensing status from a predefined list of machines. Exports results to .csv  
##########################################################################################################################################

Param
(
    [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
    [String[]]$ComputerName = $env:COMPUTERNAME
)

### Asks for user name - used in file path for source list and file export ###############################################################
$UN = Read-Host -Prompt 'Input your user name'

### Define license status values #########################################################################################################
$LicenseStatus = @("Unlicensed","Activated","OOB Grace","OOT Grace","Non-Genuine Grace","Notification","Extended Grace")

### Source list of machines to check against #############################################################################################
$computerName = Get-Content -path "C:\users\$UN\desktop\servers.txt"

### Gather info and export to .csv #######################################################################################################
Foreach($CN in $ComputerName)
{
    Get-CimInstance -ClassName SoftwareLicensingProduct -ComputerName $CN |`
    Where{$_.PartialProductKey -and $_.Name -like "*Windows*"} | select `
    @{Expression={$_.PSComputerName};Name="ComputerName"},
    @{Expression={$LicenseStatus[$($_.LicenseStatus)]};Name="LicenseStatus"} | export-csv "C:\Users\$UN\Desktop\LicenseResult.csv" -Append
}  