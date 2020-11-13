#Employee Leave
#Export information from Active Directory for employees tagged as "Leave" in PeopleSoft
$ImportPathL = "C:\Users\Burwood\Desktop\PS\HCC-Employee\Leave.txt"
$EmployeeLeave = Get-content -path $ImportPathL
$ExportPathL = "C:\users\Burwood\EmployeeLeave.csv"
foreach ($EmployeeL in $EmployeeLeave){
Get-ADUser $EmployeeL -Properties * | Select Name,EmployeeID,PasswordLastSet,LastLogonDate,EmailAddress,Enabled,@{n="ManagerName";e={get-aduser $_.manager | select -ExpandProperty name}}, @{n="ManagerMail";e={get-aduser $_.manager -properties mail | select -ExpandProperty mail}} | Export-Csv -path $ExportPathL -Append -NoTypeInformation
}

#Add Status field to end of each row
$LeaveHeaders = "C:\Users\Burwood\EmployeeLeave.txt"
$LeaveFinal = "C:\Users\Burwood\EmployeeLeaveFinal.txt"
$Leave = get-content -Path $ExportPathL

function append-text { 
  process{
   foreach-object {$_ + ',"Leave W/Py"'}
    } 
  }

$Leave | append-text | Out-file -FilePath $LeaveHeaders

#Remove header row
get-content $LeaveHeaders | select -Skip 1 | Out-file $LeaveFinal