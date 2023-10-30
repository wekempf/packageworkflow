param(
    [Parameter(Position = 0)]
    [ValidateSet('?', '.', 'version', 'clean', 'build', 'publish')]
    [string[]]$Tasks,

    [string]$Repository = 'PSGallery',
    [string]$NuGetApiKey = ([Environment]::GetEnvironmentVariable('NUGET_API_KEY'))
)

if ($MyInvocation.ScriptName -notlike '*Invoke-Build.ps1') {
    $c = "Invoke-Build $($Tasks -join ',') -File $($MyInvocation.MyCommand.Path)"
    foreach ($kv in $PSBoundParameters) {
        $c += " $($kv.Key) $($kv.Value)"
    }
    & "$PSScriptRoot/PSubShell.ps1" -NoProfile -Command $c
    return
}

Set-BuildHeader {
    param($Path)
    Write-Build Green ('=' * 79)
    $synopsis = Get-BuildSynopsis $Task
    Write-Build Green "Task $(Split-Path -Leaf $Path)$(if ($synopsis) { " - $synopsis" })"
    Write-Build DarkGray "At $($Task.InvocationInfo.ScriptName):$($Task.InvocationInfo.ScriptLineNumber)"
    Write-Build Green ''
}

Set-BuildFooter {
    param($Path)
    if ($Path -ne '/.') {
        Write-Build DarkGray ''
        Write-Build DarkGray "Task $(Split-Path -Leaf $Path) completed: $($Task.Elapsed)"
    }
}

task clean {
    Write-Build White 'Cleaning...'
}

task version {
    Write-Build White 'Versioning...'
}

task build version, clean, {
    Write-Build White 'Building...'
    mkdir '.build' -Force | Out-Null
    Set-Content -Path (Join-Path '.build' 'artifact.txt') -Value 'Hello, world!' -Force | Out-Null
}

task publish {
    Write-Build White 'Publishing...'
}

task . build
