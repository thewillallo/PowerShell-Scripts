function Add-CalendarFullAccess {
    <#
    .SYNOPSIS
    This script will set allow you to quickly give a user full access to all mailboxes or calendars that have similar naming conventions.
    .DESCRIPTION
    The Add-MailboxPermission cmdlet is used to add the user specified to each of the mailboxes returned using the Get-Mailbox cmdlet. This is useful 
    if you would like to add someone to all mailboxes that begin with a certain letter, or contain a certain string. You will need to be logged into 
    Exchange Online PowerShell in order to run this function.
    #>
    [CmdletBinding()]
    param
    (
        # $mailboxes - Retrieves all mailboxes in the environment matching a user identified string 
        # Example - {name -like "*Room*"}
        [array]$mailboxes,
        # $user - Set the user that will be grant full access
        [string]$user,
        # $logpath - Set the path for log to write to
        [string]$logpath
    )
    begin {
        $mailboxes = Get-Mailbox -Filter {name -like "*#CR*"}
        $user = Read-Host "What is the username or display name of the user that you would like to grant full access to all mailboxes?"
        $logpath = Read-Host "Enter the path you would like to save the log results to"
    }
    process {
        # Begin FOR loop
        ForEach($mailbox in $mailboxes){
            Add-MailboxPermission -Identity $mailbox.alias -User $user -AccessRights FullAccess
            Write-Output "$user granted full access to $mailbox" | Out-File "$logpath\add-calendar-full-access-results.txt" -Append
        }
    }
    end {
        Write-Output "Log written to $logpath"
    }
}