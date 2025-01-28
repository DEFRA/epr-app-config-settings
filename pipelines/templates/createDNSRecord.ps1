<#
    .SYNOPSIS
        Set-PrivateDnsRecordSet
    .DESCRIPTION
        This script creates a record set in a Private DNS zone based on the privateEndpointDnsRecordsJson variable.
#>
Param(
    [Parameter(Mandatory = $True)]
    [string]$RecordName,

    [Parameter(Mandatory = $True)]
    [string]$DNSZoneName,

    [Parameter(Mandatory = $True)]
    [string]$IPAddress,

    [Parameter(Mandatory=$False)]
    [bool]$OverwriteIfExists = $False

)


$Ttl = 300


try {

    $regionsResourceGroups = @("MSTINFDNSRGP001", "MSTINFDNSRGP201", "MSTINFDNSRGP401", "MSTINFDNSRGP601" )

    foreach($resourceGroup in $regionsResourceGroups)
    {
        Write-Output ("Setting record >")
        Write-Output ("ZoneName: $DNSZoneName")
        Write-Output ("DnsResourceGroup: " + $resourceGroup)
        Write-Output ("RecordSetName: $RecordName")
        Write-Output ("IpAddress: " + $IPAddress)
        Write-Output ("RecordType: A")
        Write-Output ("Ttl: $Ttl")

        if($OverwriteIfExists)
        {
            New-AzPrivateDnsRecordSet `
                -Name $RecordName `
                -ZoneName $DNSZoneName `
                -ResourceGroupName $resourceGroup `
                -Ttl $Ttl `
                -RecordType 'A' `
                -PrivateDnsRecords (New-AzPrivateDnsRecordConfig -Ipv4Address $IPAddress) `
                -Overwrite
        }
        else 
        {
            New-AzPrivateDnsRecordSet `
            -Name $RecordName `
            -ZoneName $DNSZoneName `
            -ResourceGroupName $resourceGroup `
            -Ttl $Ttl `
            -RecordType 'A' `
            -PrivateDnsRecords (New-AzPrivateDnsRecordConfig -Ipv4Address $IPAddress) `
        }
    }
}
catch {
    Write-Output "Error creating new Private DNS record set for $RecordName : $($_.Exception.ToString())"
    throw $_
}
