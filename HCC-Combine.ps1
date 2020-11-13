Move-Item -Path C:\Users\Burwood\EmployeeActiveFinal.txt -Destination C:\Users\Burwood\HCC-Final
Move-Item -Path C:\Users\Burwood\EmployeeDeceasedFinal.txt -Destination C:\Users\Burwood\HCC-Final
Move-Item -Path C:\Users\Burwood\EmployeeLeaveFinal.txt -Destination C:\Users\Burwood\HCC-Final
Move-Item -Path C:\Users\Burwood\EmployeeRetiredFinal.txt -Destination C:\Users\Burwood\HCC-Final
Move-Item -Path C:\Users\Burwood\EmployeeTerminatedFinal.txt -Destination C:\Users\Burwood\HCC-Final
Move-Item -Path C:\Users\Burwood\EmployeeWorkBreakFinal.txt -Destination C:\Users\Burwood\HCC-Final

Get-ChildItem C:\Users\Burwood\HCC-Final -include *.txt -rec | ForEach-Object {gc $_; ""} | out-file C:\Users\Burwood\combined.txt
(Get-Content C:\Users\Burwood\combined.txt) | Where-Object { $_ } | Set-Content C:\Users\Burwood\combined.txt