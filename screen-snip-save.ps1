$watcher = New-Object System.IO.FileSystemWatcher;

$watcher.Path = "$HOME\AppData\Local\Packages\MicrosoftWindows.Client.CBS_cw5n1h2txyewy\TempState\ScreenClip";

$watcher.Filter = "*.png";

$watcher.NotifyFilter = "FileName";

$watcher.EnableRaisingEvents = $true;

$action = {

    $path = $Event.SourceEventArgs.FullPath;

    # Last chance for a file to unlock;
    Start-Sleep -Milliseconds 100;
    
    try {

        Add-Type -AssemblyName System.Drawing;

        # Open image file;
        $png = [System.Drawing.Image]::FromFile((Get-Item $path));

        $dimensions = -join ($png.Width, " x ", $png.Height);

        # Skip automatic thumbnails which are always the same size;
		If ($dimensions -ne "364 x 180") {
             Copy-Item -Path $path -Destination "$HOME\Downloads\Screenshot-$(get-date -f yyyy-MM-dd-HHmmss.fff).png"; 
        }
        
    } catch {
        
        Write-Host "Problem acquiring image";

    } finally {
        
        $png.Dispose();
    }

}

Register-ObjectEvent -InputObject $watcher -EventName "Created" -SourceIdentifier 'SnipGrab' -Action $action;

Remove-Item -Path (Join-Path $watcher.Path '\*') -Recurse;

while ($true){  Wait-Event -SourceIdentifier "SnipGrab";  };
