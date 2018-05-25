function Get-BIAuditLogsDaily {
    <#
    .SYNOPSIS
    This script will get daily PowerBI Audit Logs and deliver them to a file share.
    .DESCRIPTION
    The Search-UnifiedAuditLog cmdlet is used to search Office 365 audit logs. In this function it is used to retrieve PowerBI logs. 
    This function is intended to be ran daily as a script, to deliver reports to a file share on the network. Exchange Online PowerShell session 
    with appropriate permissions to run this. You can incorporate the Office 365 log in process before this function in a daily script. 
    In addition, the user will need appropriate Office 365 admin privileges to access the audit logs.
    #>
    [CmdletBinding()]
    param
    (
        [datetime]$date,
        [string]$dateString,
        [datetime]$past,
        [string]$pastString,
        [string]$path
    )
    begin {
        $date = Get-Date
        $dateString = $date.ToString("MM/dd/yyyy")
        $past = $date.AddDays(-1)
        $pastString = $past.ToString("MM/dd/yyyy")
        $path = "<Enter the file share path>"
    }
    process {
        # Search PowerBI log using the prior day as the start and the current date as the end date
        Search-UnifiedAuditLog -StartDate $pastString -EndDate $dateString -RecordType PowerBI -ResultSize 1000 | `
        Export-CSV ($path + "PowerBI-AuditLogs.csv" + $date.ToString("yyyyMMdd"))
    }
}