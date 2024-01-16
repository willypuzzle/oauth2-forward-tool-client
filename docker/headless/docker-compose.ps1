param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("up", "down", "build")]
    [string]$Action,

    [Parameter(Mandatory=$false)]
    [ValidateSet("-d", "--no-cache", "")]
    [string]$Option = ""
)

$scriptDirectory = Split-Path -Parent $PSCommandPath

$envFilePath = Join-Path -Path $scriptDirectory -ChildPath "..\.node_configuration.env"


$envLines = Get-Content -Path $envFilePath

foreach ($line in $envLines) {
    if ($line -match '^\s*#') {
        continue
    }

    $parts = $line -split '=', 2

    if ($parts.Length -eq 2) {
        $envName = $parts[0].Trim()
        $envValue = $parts[1].Trim()

        Set-Item -Path Env:$envName -Value $envValue
    }
}

$command = "docker-compose -f $scriptDirectory\docker-compose.yml $Action $Option"

Invoke-Expression $command

