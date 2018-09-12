#This script will create email alerts for low licenses for Office 365 services

#Connect to the Microsoft Online service
Connect-MsolService

#Get available services
$services = Get-MsolAccountSku | Select AccountSkuID

#Add your mail relay
$smtpServer = "smtp relay name"
$subject = "Low License Alert!"
$recipient = "o365.licensealerts@domain.com"
$from = "o365.licensealerts@domain.com"
#Set the threshold for when you would like to receive an alert
$floor = 30

#Loop through each service and send an email if licenses are below floor number
ForEach($service in $services.AccountSkuID){
    $activeUnits = (Get-MsolAccountSku | where {$_.AccountSkuId -eq $service}).ActiveUnits
    $consumedUnits = (Get-MsolAccountSku | where {$_.AccountSkuId -eq $service}).ConsumedUnits
    $remainingUnits = $activeUnits - $consumedUnits
        If($remainingUnits -lt $floor){
            $body = "This is a low license alert for the $service licenses.<br><br>"
            $body += "There are only $remainingUnits licenses left.<br><br>"
            $body += "Click <a href='https://www.microsoft.com/Licensing/servicecenter/default.aspx'>here</a> to order more."
            Send-MailMessage -From $from -To $recipient -Subject $subject -Body $body -BodyAsHtml -Priority high -SmtpServer $smtpServer
        }
}

