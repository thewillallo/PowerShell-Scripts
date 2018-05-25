function AddFullAccessMailboxPermission {
    <#
    .SYNOPSIS
    This script will set allow you to quickly give a user full access to all mailboxes or calendars that have similar naming conventions.
    .DESCRIPTION
    The Add-MailboxPermission cmdlet is used to add the user specified to each of the mailboxes returned using the Get-Mailbox cmdlet. This is useful 
    if you would like to add someone to all mailboxes that begin with a certain letter, or contain a certain string. You will need to be logged into 
    Exchange Online PowerShell in order to run this function.
    #>
    param(
        # $mailboxes - Retrieves all mailboxes in the environment matching a user identified string 
        # Example - {name -like "*Room*"}
        [string]$mailboxes = Get-Mailbox -Filter {name -like "<enter conference room name similarity unique to your environment>"}
        # $user - Set the user that will be grant full access
        [string]$user = Read-Host "What is the username of the user that you would like to grant full access to all mailboxes?"

        # Begin FOR loop
        ForEach($mailbox in $mailboxes){
            Add-MailboxPermission -Identity $mailbox.alias -User $user -AccessRights FullAccess
        }
    )