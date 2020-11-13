#Employee Terminated
#Export information from Active Directory for employees tagged as "Terminated" in PeopleSoft
$ImportPathT = "C:\Users\Burwood\Desktop\PS\HCC-Employee\Terminated.txt"
$EmployeeTerminated = Get-content -path $ImportPathT
$ExportPathT = "C:\users\Burwood\EmployeeTerminated.csv"
foreach ($EmployeeT in $EmployeeTerminated){
Get-ADUser $EmployeeT -Properties * | Select Name,EmployeeID,PasswordLastSet,LastLogonDate,EmailAddress,Enabled,@{n="ManagerName";e={get-aduser $_.manager | select -ExpandProperty name}}, @{n="ManagerMail";e={get-aduser $_.manager -properties mail | select -ExpandProperty mail}} | Export-Csv -path $ExportPathT -Append -NoTypeInformation
}

#Add Status field to end of each row
$TerminatedHeaders = "C:\Users\Burwood\EmployeeTerminated.txt"
$TerminatedFinal = "C:\Users\Burwood\EmployeeTerminatedFinal.txt"
$Terminated = get-content -Path $ExportPathT

function append-text { 
  process{
   foreach-object {$_ + ',"Terminated"'}
    } 
  }

$Terminated | append-text | Out-file -FilePath $TerminatedHeaders

#Remove header row
get-content $TerminatedHeaders | select -Skip 1 | Out-file $TerminatedFinal