Start-Process -FilePath C:\Windows\System32\PresentationSettings.exe /start
[system.Diagnostics.Process]::Start("C:\Program Files\Google\Chrome\Application\chrome.exe","https://web.whatsapp.com")

$processes = 'C:\Program Files\Microsoft Office\root\Office16\ONENOTE.EXE',
             '"https://cyberark.my.idaptive.app/"',
             '"https://google.com"',
             'C:\Program Files\Microsoft VS Code\Code.exe',
             'C:\Program Files (x86)\VMware\VMware Workstation\vmware.exe',
             'C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE'

foreach($process in $processes){
        Start-Process -FilePath $process
}