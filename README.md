# x-powershell
Windows PowerShell scripts

1. Windows Snip & Sketch Tool (`Win+Shift+S` / `PrtScrn`) gets to autosave a screenshot, see also a [post on SuperUser](https://superuser.com/questions/1436068/auto-save-script-for-windows-shift-win-s-hotkey/1649816#1649816).

   Create a Task in Scheduler with **Action:** `powershell`, **Arguments:** `-Command "Get-Content -Path 'D:\Apps\Windows Powershell Scripts\ScreenSnip Manager\Activate.ps1' -Raw | Invoke-Expression"`
2. Clear Recent Entries, keep Pinned QuickAccess (Explorer sidebar) items

   Create a shortcut to run the script on demand with target `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File "D:\Apps\Windows Powershell Scripts\ClearRecents\ClearRecentEntries.ps1"`
   
