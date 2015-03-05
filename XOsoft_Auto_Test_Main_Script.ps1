###########################################
# XOsoft_Auto_Test_Main_Script
# This is a sample script of AUTO Test
# Date: 2008-04-03
###########################################

set-executionpolicy Unrestricted

write-host "XOsoft_Auto_Test_Main_Script starting"

set-location C:\XOAutoScript\

$ep = get-executionpolicy
if ($ep -eq 'unrestricted') {
  write-warning ": script running in unrestricted mode`n"
}

$thistime = get-date -format yyyy.M.dd.HH.mm.ss
#$thistime > "C:\XOAutoScript\Results\$thistime.result.txt"
$ResultSummary="C:\XOAutoScript\Results\$thistime.result.txt"

$f = get-content C:\XOAutoScript\cc.txt

$TotalCount=0
$TotalFail=0
$TotalPass=0
foreach ($line in $f)
{
  write-host "-----------------------------------------------------------"
  $TotalCount=$TotalCount+1
  $tokens = $line.split('@')
  $caseID = $tokens[0]
  $Content = $tokens[1]
  $ExpectedFile = $tokens[2]
  $Actual = $tokens[3] 
  $Results = 'Fail'
  
  write-host "Case ID : $caseID  "
  write-host "Inputs  : $content" 
  write-host "Expected: $expectedfile    "
  write-host "Actual  : $Actual"
  write-host "-----------------------------------------------------------"
  write-host "$caseID is running: " 
  
  invoke-expression $content
  
  $ExpectedContent = get-content "$ExpectedFile" -totalcount 1 
	$ActualContent = get-content $Actual 

	foreach ($Result_line in $ActualContent)
	{
		if($Result_line.ToLower().Contains($ExpectedContent.ToLower()))		
	  {
			$Results = 'Pass'
			break
	  }
  }

   if([string]::Compare($Results, 'FAIL', $True))
   {
   	$TotalPass = $TotalPass+1
   	write-host $caseID 'Pass' -backgroundcolor green -foregroundcolor darkblue
   }
   else
   {
   	$TotalFail = $TotalFail+1
   	write-host $caseID "*FAIL*" -backgroundcolor red	
   }
      
   "$caseID  $Results" >> C:\XOAutoScript\ResultSummary.txt
   "$caseID  $Results" >> $ResultSummary
	
	write-host "Case$caseID is stopped" 
	write-host "" 
	write-host "" 
	
}  #main loop


"Passed: $TotalPass" >> C:\XOAutoScript\ResultSummary.txt
"Failed: $TotalFail" >> C:\XOAutoScript\ResultSummary.txt
"Total Case Number: $TotalCount" >> C:\XOAutoScript\ResultSummary.txt

"Passed: $TotalPass" >> $ResultSummary
"Failed: $TotalFail" >> $ResultSummary
"Total Case Number: $TotalCount" >> $ResultSummary


# End AUTO script
write-host "XOsoft_Auto_Test_Main_Script end"





