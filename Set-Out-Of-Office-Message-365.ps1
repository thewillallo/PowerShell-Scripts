function Set-OutOfOffice {
    <#
    .SYNOPSIS
    This script will set the auto reply for any user in your Office 365 tenant.
    .DESCRIPTION
    The Set-MailboxAutoReplyConfiguration cmdlet sets auto-reply messages for Office 365 mailboxes. The mailbox can be either enabled
    or disabled. This function will provide an option to set replies for either internal or external senders. You must be logged in to
    Exchange Online PowerShell session with appropriate permissions to run this.
    #>
    param(
        # $user - the username of the mailbox owner whose message is being set
        [string]$user = Read-Host "What is the username of the user whose auto-reply you would like to set?"
        # $message - the content of the message being generated as an out of office reply
        [string]$message = Read-Host "What should the auto-reply message be for mail received internally?"
        # $opt - the option presented to the admin to set the message for both internal and external senders
        [string]$opt = Read-Host "Would you like to use the same message externally? (Yes or No)"
    )
        # Prompts for acceptable response if not provided
        while("yes","no" -notcontains $opt) {
	    $opt = Read-Host "Please respond Yes or No"
        }
        # Sets out of office responses internally and externally
        If ($opt -eq "Yes") {
            Set-MailboxAutoReplyConfiguration -Identity $user -AutoReplyState enabled -InternalMessage $message -ExternalMessage $message 
        } Else {
            $extMessage = Read-Host "What would you like the external message to be?"
            Set-MailboxAutoReplyConfiguration -Identity $user -AutoReplyState enabled -InternalMessage $message -ExternalMessage $extMessage 
    
}
