param(
	[switch]$Upgrade
)

$packages = @{
	'cURL.cURL' = '8.19.0.5'
	'tree-sitter.tree-sitter-cli' = '0.26.7'
}

Write-Host "Installing external dependencies..."
foreach ($pkgId in $packages.Keys) {
	Write-Host "Installing ${pkgId} @ ${pkgVersion}..."
	if ($Upgrade) {
		winget pin remove --id $pkgId
	}
	$pkgVersion = $packages[$pkgId]
    winget install --id $pkgId --version $pkgVersion --exact
	winget pin add --id $pkgId
}
Write-Host "Installing external dependencies: done!"
