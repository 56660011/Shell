$servers = @("BP-HyperV2", "BP-HyperV1", "GF-INTRANET", "BP-SQL-SP", "BP-SQL-PROD", "BP-OWebApp", "BP-DHCP02", "BP-HyperV3", "BP-DHCP01", "GFPT-ADS02","GFPT-EXC03", "GFPT-PRS", "GFPTBP-DATA")

Foreach ($server in $servers)
{

    $disks = Get-WmiObject Win32_LogicalDisk -ComputerName $server -Filter DriveType=3 | 
        Select-Object DeviceID, 
            @{'Name'='Size'; 'Expression'={[math]::truncate($_.size / 1GB)}}, 
            @{'Name'='Freespace'; 'Expression'={[math]::truncate($_.freespace / 1GB)}}

    $server

    foreach ($disk in $disks)
    {
        $disk.DeviceID + $disk.FreeSpace.ToString("N0") + "GB / " + $disk.Size.ToString("N0") + "GB"

     }
     Write-Host '----------------------------------------------------------------------------------------------'
 }

Write-Host "BP-DBS"
Invoke-Command -ComputerName bp-dbs {Get-PSDrive | Where {$_.Free -gt 0}}