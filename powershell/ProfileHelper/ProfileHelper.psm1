function Get-LastExecutionDuration {
	$History = (Get-History)
	if ($History.Length -eq 0) {
		return New-TimeSpan
	}
	$EndTime = (Get-History)[-1].EndExecutionTime
	$StartTime = (Get-History)[-1].StartExecutionTime
	return ($EndTime - $StartTime)
}

function IsWindows {
	return ($Env:OS -match "Windows.*")
}

function Format-Location {
	param([string]$Location)
	$Home = $HOME
	if (IsWindows) {
		$Home = ($HOME -split "\\") -join '\\'
	}
	$Location = $Location -replace "${HOME}","~"
	return $Location
}

function Format-ExecutionDuration {
	param([TimeSpan]$Duration)
	$Days = $Duration.Days
	$Hours = $Duration.Hours
	$Minutes = $Duration.Minutes
	$Seconds = $Duration.Seconds
	$Milliseconds = $Duration.Milliseconds
	if ($Days -gt 0) {
		return "{0}d{0}h{0}m{0}s{0}ms" -f $Days,$Hours,$Minutes,$Seconds,$Milliseconds
	}
	if ($Hours -gt 0) {
		return "{0}h{0}m{0}s{0}ms" -f $Hours,$Minutes,$Seconds,$Milliseconds
	}
	if ($Minutes -gt 0) {
		return "{0}m{0}s{0}ms" -f $Minutes,$Seconds,$Milliseconds
	}
	if ($Seconds -gt 0) {
		return "{0}s{0}ms" -f $Seconds,$Milliseconds
	}
	if ($Milliseconds -gt 0) {
		return "{0}ms" -f $Milliseconds
	}
	return ""
}
