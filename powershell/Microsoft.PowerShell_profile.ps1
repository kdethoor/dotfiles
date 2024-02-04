Import-Module -Name $($($(Get-Item $PROFILE).Directory.FullName) + "/ProfileHelper")

# Prompt
function prompt {
	$Location = Format-Location $(Get-Location)
	$Duration = Get-LastExecutionDuration
	$Duration = Format-ExecutionDuration $Duration

	Write-Host "[${Env:COMPUTERNAME}]" -foregroundcolor Green -nonewline
	Write-Host " ${Location}" -foregroundcolor Blue -nonewline
	Write-Host " ${Duration}" -foregroundcolor Yellow

	Write-Host "$([char]0x276F)" -foregroundcolor Red -nonewline
	return " "	
}

# Visual Studio
## Source: https://stackoverflow.com/questions/2124753/how-can-i-use-powershell-with-the-visual-studio-command-prompt
function Import-VsDevCmd {
	Write-Host "This method is deprecated, please use 'Enter-VsDevShell'" -ForegroundColor Yellow
	return;

	##$VsTools = "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools"
	##$VsScript = "VsDevCmd.bat"
	##if (Test-Path -Path $VsTools) {
	##	pushd $VsTools
	##	cmd /c "${VsScript}&set" |
	##	foreach {
	##	  if ($_ -match "=") {
	##		$v = $_.split("=", 2); set-item -force -path "ENV:\$($v[0])"  -value "$($v[1])"
	##	  }
	##	}
	##	popd
	##	Write-Host "Visual Studio 2022 Command Prompt variables set." -ForegroundColor Green
	##}
	##else {
	##	Write-Host "VsDevCmd.bat not found at ${VsTools}\${VsScript}." -ForegroundColor Red
	##}
}

function Enter-VsDevShell {
	param (
		[string]$arch
	)
	$VsScript = 'C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Launch-VsDevShell.ps1'
	if (Test-path -Path $VsScript) {
		& "${VsScript}" "${arch}" -SkipAutomaticLocation
	}
	else
	{
		Write-Host "Could not find ${VsScript}. Is Visual Studio installed?" -ForegroundColor Red
	}
}

## Aliases
Set-Alias vim nvim

## Local profile
if (Test-Path -Path "$((Get-Item $PROFILE).Directory.FullName)/Local.ps1") {
	. "$((Get-Item $PROFILE).Directory.FullName)/Local.ps1"
}
