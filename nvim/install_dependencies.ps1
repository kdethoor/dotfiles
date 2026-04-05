param(
	[switch]$Upgrade,
	[switch]$IncludeLSPs
)

function Install-Dependencies{
    param(
        $PackageMap,
        $PackageMapName,
        [switch]$Upgrade
    )

	Write-Host "Installing ${PackageMapName} dependencies..."
	foreach ($pkgId in $PackageMap.Keys) {
		$pkgVersion = $PackageMap[$pkgId]
		Write-Host "Installing ${pkgId} @ ${pkgVersion}..."
		if ($Upgrade) {
			winget pin remove --id $pkgId
		}
		winget install --id $pkgId --version $pkgVersion
		winget pin add --id $pkgId
	}
	Write-Host "Installing ${PackageMapName} dependencies: done!"
}

$packages = @{
	'cURL.cURL' = '8.19.0.5'
	'tree-sitter.tree-sitter-cli' = '0.26.7'
    'sharkdp.fd' = '10.4.2'
    'Kitware.CMake' = '4.3.0'
}

$lspPackages = @{
	'clangd' = '22.1.0'
}

Install-Dependencies $packages "base" $Upgrade
if ($IncludeLSPs) {
	Install-Dependencies -PackageMap $lspPackages -PackageMapName "LSP" -Upgrade $Upgrade
}

Write-Host "Installing dependencies: done!"
