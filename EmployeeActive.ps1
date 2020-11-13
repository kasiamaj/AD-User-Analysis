#Employee Active
#Export information from Active Directory for employees tagged as "Active" in PeopleSoft
$ImportPathA = "C:\Users\Burwood\Desktop\PS\HCC-Employee\Active.txt"
$EmployeeActive = Get-content -path $ImportPathA
$ExportPathA = "C:\users\Burwood\EmployeeActive.csv"
foreach ($EmployeeA in $EmployeeActive){
Get-ADUser $EmployeeA -Properties * | Select Name,EmployeeID,PasswordLastSet,LastLogonDate,EmailAddress,Enabled,@{n="ManagerName";e={get-aduser $_.manager | select -ExpandProperty name}}, @{n="ManagerMail";e={get-aduser $_.manager -properties mail | select -ExpandProperty mail}} | Export-Csv -path $ExportPathA -Append -NoTypeInformation
}

#Add Status field to end of each row
$ActiveHeaders = "C:\Users\Burwood\EmployeeActiveFinal.txt"
$Active = get-content -Path $ExportPathA

function append-text { 
  process{
   foreach-object {$_ + ',"Active"'}
    } 
  }

$Active | append-text | Out-file -FilePath $ActiveHeaders
