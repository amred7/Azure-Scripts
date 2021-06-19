#get the list of LAW and there LinkedServices

$laws = (az monitor log-analytics workspace list) | ConvertFrom-Json

$arrayLinks = @()
foreach ($law in $laws) {
    Write-Host $law.name
    Write-Host $law.resourceGroup
    $link = (az monitor log-analytics workspace linked-service list -g $law.resourceGroup --workspace-name  $law.name ) | ConvertFrom-Json
    foreach ($l in $link) {
       Write-Host $link.resourceId
       Write-Host "finBoucle"   
       $arrayLinks = $arrayLinks + $l
    }
  
}

Write-Host "the Array of result links"
Write-Host $arrayLinks 
$arrayLinks | Export-Csv -Path "listOfLinkedService.csv"

