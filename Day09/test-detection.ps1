param(
    [string]$EvidencePath = $PSScriptRoot
)

$expected = @{
    'parent-event.xml' = $true
    'child-event.xml'  = $false
}

$results = foreach ($fileName in $expected.Keys) {

    $file = Join-Path $EvidencePath $fileName
    [xml]$xml = Get-Content $file -Raw

    $data = @{}

    foreach ($item in $xml.Event.EventData.Data) {
        $data[$item.GetAttribute('Name')] = $item.InnerText
    }

    $matched = (
        $data['Image'] -match '\\notepad\.exe$' -and
        $data['ParentImage'] -match '\\powershell\.exe$'
    )

    [PSCustomObject]@{
        EvidenceFile = $fileName
        ProcessId = $data['ProcessId']
        Image = $data['Image']
        ParentImage = $data['ParentImage']
        Expected = $expected[$fileName]
        Actual = $matched
        Passed = ($matched -eq $expected[$fileName])
    }
}

$results = @($results)

$results | Format-Table EvidenceFile, Expected, Actual, Passed -AutoSize

$results | Export-Csv (
    Join-Path $EvidencePath 'automated-validation.csv'
) -NoTypeInformation

$passed = @($results | Where-Object { $_.Passed }).Count

Write-Host "Tests passed: $passed / $($results.Count)"

if ($passed -ne $results.Count) {
    exit 1
}

