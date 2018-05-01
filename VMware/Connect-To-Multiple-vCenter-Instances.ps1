$Credentials = Get-Credential

$vserver1 = "vcenter1.domain.local"
$vserver2 = "vcenter2.domain.local"
$vserver3 = "vcenter3.domain.local"

Connect-VIServer "$vserver1","$vserver2","$vserver3" -Credential $Credentials