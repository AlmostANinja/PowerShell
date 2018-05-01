# This will prompt you for credentials
$Credentials = Get-Credential

#Change the below to reflect your vCenter information or comment / add additional variables if you wish
$vserver1 = "vcenter1.domain.local"
$vserver2 = "vcenter2.domain.local"
$vserver3 = "vcenter3.domain.local"

#The connection string. Remember if you comment/add additional variables above, you would need to edit below. 
Connect-VIServer "$vserver1","$vserver2","$vserver3" -Credential $Credentials