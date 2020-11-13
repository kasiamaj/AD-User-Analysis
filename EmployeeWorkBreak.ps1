#Employee Work Break
#Export information from Active Directory for employees tagged as "Work Break" in PeopleSoft
$ImportPathW = "C:\Users\Burwood\Desktop\PS\HCC-Employee\Break.txt"
$EmployeeWorkBreak = Get-content -path $ImportPathW
$ExportPathW = "C:\users\Burwood\EmployeeWorkBreak.csv"
foreach ($EmployeeW in $EmployeeWorkBreak){
Get-ADUser $EmployeeW -Properties * | Select Name,EmployeeID,PasswordLastSet,LastLogonDate,EmailAddress,Enabled,@{n="ManagerName";e={get-aduser $_.manager | select -ExpandProperty name}}, @{n="ManagerMail";e={get-aduser $_.manager -properties mail | select -ExpandProperty mail}} | Export-Csv -path $ExportPathW -Append -NoTypeInformation
}

#Add Status field to end of each row
$BreakHeaders = "C:\Users\Burwood\EmployeeWorkBreak.txt"
$BreakFinal = "C:\Users\Burwood\EmployeeWorkBreakFinal.txt"
$Break = get-content -Path $ExportPathW

function append-text { 
  process{
   foreach-object {$_ + ',"Work Break"'}
    } 
  }

$Break | append-text | Out-file -FilePath $BreakHeaders

#Remove header row
get-content $BreakHeaders | select -Skip 1 | Out-file $BreakFinal