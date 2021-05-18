# Write-Host "`nClearing . . . " -NoNewline

Get-ChildItem $env:APPDATA\Microsoft\Windows\Recent\* -File -Force -Exclude desktop.ini | 
Remove-Item -Force -ErrorAction SilentlyContinue
Get-ChildItem $env:APPDATA\Microsoft\Windows\Recent\AutomaticDestinations\* -File -Force -Exclude desktop.ini, f01b4d95cf55d32a.automaticDestinations-ms | 
Remove-Item -Force -ErrorAction SilentlyContinue
Get-ChildItem $env:APPDATA\Microsoft\Windows\Recent\CustomDestinations\* -File -Force -Exclude desktop.ini | 
Remove-Item -Force -ErrorAction SilentlyContinue

# Clear unpinned folders from Quick Access, using the Verbs() method
$UnpinnedQAFolders = (0,0)
While ($UnpinnedQAFolders) {
    $UnpinnedQAFolders = (((New-Object -ComObject Shell.Application).Namespace("shell:::{679f85cb-0220-4080-b29b-5540cc05aab6}").Items() | 
    where IsFolder -eq $true).Verbs() | where Name -match "Remove from Quick access")
    If ($UnpinnedQAFolders) { $UnpinnedQAFolders.DoIt() }
}

# Write-Host "Done!`n"
# Stop-Process -Name explorer -Force

Remove-Variable UnpinnedQAFolders
