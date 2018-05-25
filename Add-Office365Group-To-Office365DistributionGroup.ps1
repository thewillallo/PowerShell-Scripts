function Add-Office365GroupToDistro {
    <#
    .SYNOPSIS
    This script will set allow you to nest an Office 365 Group in an Office 365 Distribution Group.
    .DESCRIPTION
    The Add-DistributionGroupMember cmdlet can be used to add the SMTP address of an Office 365 Group to an Office 365 Distribution Group.
    This is not available in the Office 365 Exchange Admin GUI. This is useful if you would like the members of an Office 365 Group to receive
    messages sent to a different Office 365 Distribution Group in your tenant. You will need to be logged into Exchange Online PowerShell in
    order to run this function.
    #>
    param
    (
        # $distro - Prompts for the distribution group SMTP address
        [string]$distro,
        # $member - Prompts for the Office 365 Group SMTP address
        [string]$member
    )
    begin {
        $distro = Read-Host "Enter the SMTP address of the Office 365 Distribution Group"
        $member = Read-Host "Please enter the SMTP address of the Office 365 Group you would like to add to the $distro Distribution Group"
    }
    process {
        Do {
            # Command to set the distribution group
            Add-DistributionGroupMember -Identity $distro -Member $member
            # Ask question to 
            $question = Read-Host "Would you like to add more Office 365 groups to this distribution group? (Yes or No)"
            # End DO loop, will terminate if response to $question does not equal "Yes"
        } Until (($question -ne "Yes") -or ($question -ne "yes"))
    }
    end {
        Write-Output "Script is complete"
    }
}






