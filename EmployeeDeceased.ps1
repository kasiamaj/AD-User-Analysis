#Employee Decesased
#Export information from Active Directory for employees tagged as "Deceased" in PeopleSoft
$ImportPathD = "C:\Users\Burwood\Desktop\PS\HCC-Employee\Deceased.txt"
$EmployeeDeceased = Get-content -path $ImportPathD
$ExportPathD = "C:\users\Burwood\EmployeeDeceased.csv"
foreach ($EmployeeD in $EmployeeDeceased){
Get-ADUser $EmployeeD -Properties * | Select Name,EmployeeID,PasswordLastSet,LastLogonDate,EmailAddress,Enabled,@{n="ManagerName";e={get-aduser $_.manager | select -ExpandProperty name}}, @{n="ManagerMail";e={get-aduser $_.manager -properties mail | select -ExpandProperty mail}} | Export-Csv -path $ExportPathD -Append -NoTypeInformation
}

#Add Status field to end of each row
$DeceasedHeaders = "C:\Users\Burwood\EmployeeDeceased.txt"
$DeceasedFinal = "C:\Users\Burwood\EmployeeDeceasedFinal.txt"
$Deceased = get-content -Path $ExportPathD

function append-text { 
  process{
   foreach-object {$_ + ',"Deceased"'}
    } 
  }

$Deceased | append-text | Out-file -FilePath $DeceasedHeaders

#Remove header row
get-content $DeceasedHeaders | select -Skip 1 | Out-file $DeceasedFinal