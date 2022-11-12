### Function to query the ipify Public IP Address API and returns your public IP.
function Get-PublicIP {
    $uri = 'https://api.ipify.org'
    try {
        $invokeRestMethodSplat = @{
            Uri         = $uri 
            ErrorAction = 'Stop'
        }
        $publicIP = Invoke-RestMethod @invokeRestMethodSplat
    }
    catch {
        Write-Error $_
    }
    return $publicIP
} #Get-PublicIP