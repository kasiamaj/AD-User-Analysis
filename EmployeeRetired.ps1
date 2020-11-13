#Employee Retired
#Export information from Active Directory for employees tagged as "Retired" in PeopleSoft
$ImportPathR = "C:\Users\Burwood\Desktop\PS\HCC-Employee\Retired.txt"
$EmployeeRetired = Get-content -path $ImportPathR
$ExportPathR = "C:\users\Burwood\EmployeeRetired.csv"
foreach ($EmployeeR in $EmployeeRetired){
Get-ADUser $EmployeeR -Properties * | Select Name,EmployeeID,PasswordLastSet,LastLogonDate,EmailAddress,Enabled,@{n="ManagerName";e={get-aduser $_.manager | select -ExpandProperty name}}, @{n="ManagerMail";e={get-aduser $_.manager -properties mail | select -ExpandProperty mail}} | Export-Csv -path $ExportPathR -Append -NoTypeInformation
}

#Add Status field to end of each row
$RetiredHeaders = "C:\Users\Burwood\EmployeeRetired.txt"
$RetiredFinal = "C:\Users\Burwood\EmployeeRetiredFinal.txt"
$Retired = get-content -Path $ExportPathR

function append-text { 
  process{
   foreach-object {$_ + ',"Retired"'}
    } 
  }

$Retired | append-text | Out-file -FilePath $RetiredHeaders

#Remove header row
get-content $RetiredHeaders | select -Skip 1 | Out-file $RetiredFinal