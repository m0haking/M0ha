function Show-Header {
    Clear-Host
    Write-Host "======================================" -ForegroundColor Cyan
    Write-Host "    YOUTUBE TOOL BY m0ha [v3.0]       " -ForegroundColor Magenta
    Write-Host "    GENERATE & CHECK HANDLES          " -ForegroundColor Yellow
    Write-Host "======================================" -ForegroundColor Cyan
}

function Generate-User($length) {
    $chars = "abcdefghijklmnopqrstuvwxyz0123456789._"
    $user = ""
    for ($i = 0; $i -lt $length; $i++) {
        $user += $chars[(Get-Random -Minimum 0 -Maximum $chars.Length)]
    }
    return $user
}

function Check-User($user) {
    $url = "https://www.youtube.com/@$user"
    $desktopPath = [System.IO.Path]::Combine($env:USERPROFILE, "Desktop", "available_m0ha.txt")
    try {
        $request = Invoke-WebRequest -Uri $url -Method Get -ErrorAction Stop -MaximumRedirection 0 -UseBasicParsing
        Write-Host "[-] @$user -> TAKEN" -ForegroundColor Red
    }
    catch {
        if ($_.Exception.Response.StatusCode -eq "NotFound") {
            Write-Host "[+] @$user -> AVAILABLE !!!" -ForegroundColor Green
            "@$user" | Out-File -FilePath $desktopPath -Append
        }
        else {
            Write-Host "[!] @$user -> CONNECTION ERROR" -ForegroundColor Yellow
        }
    }
}

Show-Header
$len = Read-Host "Enter handle length (e.g. 4)"
$num = Read-Host "How many handles to check?"

Write-Host "`n[!] Checking... Hits saved to your Desktop`n" -ForegroundColor Cyan

for ($i = 1; $i -le $num; $i++) {
    $randomUser = Generate-User -length $len
    Check-User -user $randomUser
    Start-Sleep -Milliseconds 600
}

Write-Host "`nDONE! Check available_m0ha.txt on your Desktop." -ForegroundColor Magenta
Pause
