Import-Module -Name $($($(Get-Item $PROFILE).Directory.FullName) + "/ProfileHelper")

function prompt {
	$Location = Format-Location $(Get-Location)
	$Duration = Get-LastExecutionDuration
	$Duration = Format-ExecutionDuration $Duration

	Write-Host "${Location}" -foregroundcolor Blue -nonewline
	Write-Host " ${Duration}" -foregroundcolor Yellow

	Write-Host "$([char]0x276F)" -foregroundcolor Red -nonewline
	return " "	
}

if (Test-Path -Path "$((Get-Item $PROFILE).Directory.FullName)/Local.ps1") {
	. "$((Get-Item $PROFILE).Directory.FullName)/Local.ps1"
}
