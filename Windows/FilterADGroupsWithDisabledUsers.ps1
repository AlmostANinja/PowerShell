Write-Host "Importing the ActiveDirectory Module" -foregroundcolor green
Import-Module ActiveDirectory | out-null		
Write-Host "Filtering AD Groups" -foregroundcolor green

#This will filter your groups. Change *changeme* to the group(s) you want filter. Keep the * if you want to wildcard it 
$Groups = (Get-AdGroup -filter * | Where {$_.name -like "*signatures*"} | select Name -expandproperty Name)
Write-Host "Preparing the CSV Template" -foregroundcolor green

#This will create the template for you to export to CSV 
$csv = @() 
$Record = [ordered]@{ 
"Group Name" = "" 
"Name" = "" 
"Username" = "" 
"Enabled" = ""
} 
Write-Host "The Magic is happening. Getting all Disabled Members" -foregroundcolor green

#The Magic
Foreach ($Group in $Groups) 
{ 
	$ArrayOfMembers = Get-ADGroupMember -Identity $Group -Recursive | %{Get-ADUser -Identity $_.distinguishedName -Properties Enabled | ?{$_.Enabled -eq $false}} | Select Name,SamAccountname,Enabled
	foreach ($Member in $Arrayofmembers) 
	{
		$Record."Group Name" = $Group
		$Record."Name" = $Member.Name
		$Record."UserName" = $Member.SamAccountname
		$Record."Enabled" = $Member.Enabled
		$objRecord = New-Object PSObject -property $Record
		$csv += $objrecord
	} 
}

#The Export
Write-Host "Exporting to CSV" -foregroundcolor green
$csv | export-csv "C:\temp\ADSecurityGroups.csv" -NoTypeInformation | out-null
Write-Host "Complete" -foregroundcolor green