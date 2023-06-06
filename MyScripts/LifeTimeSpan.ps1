$MyName = "Lucas"
$MyBirthday = "4/25/1991, 8:45AM"

#
$MyBirthdayVar = $MyBirthday | Get-Date
$MyAge = ((Get-Date).Year) - (($MyBirthdayVar).Year)
$TimeSpan = (Get-Date) -  $MyBirthdayVar
$TimeSpanDays = $TimeSpan.Days
$TimeSpanHours = $TimeSpan.Hours
$TimeSpanMinutes = $TimeSpan.Minutes
$TimeSpanSeconds = $TimeSpan.Seconds
$TimeSpanMilliseconds = $TimeSpan.Milliseconds
$DayOfWeekVar = $MyBirthDayVar.DayOfWeek
$RetirementDate = $MyBirthdayVar.AddYears(65)

Write-Host ("$MyName, You were born in $MyBirthdayVar
The day of the week was $DayOfWeekVar
You are $MyAge years old
You are on this earth for $TimeSpanDays days, $TimeSpanHours hours, $TimeSpanMinutes minutes, $TimeSpanSeconds seconds and $TimeSpanMilliseconds milliseconds
You should be able to retire on $RetirementDate")
