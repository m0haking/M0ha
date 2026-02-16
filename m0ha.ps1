function Show-Header {
    Clear-Host
    Write-Host "======================================" -ForegroundColor Cyan
    Write-Host "    YOUTUBE TOOL BY m0ha [v1.0]       " -ForegroundColor Magenta
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
    try {
        $request = Invoke-WebRequest -Uri $url -Method Get -ErrorAction Stop -MaximumRedirection 0
        Write-Host "[-] @$user -> TAKEN" -ForegroundColor Red
    }
    catch {
        if ($_.Exception.Response.StatusCode -eq "NotFound") {
            Write-Host "[+] @$user -> AVAILABLE !!!" -ForegroundColor Green
            "@$user" | Out-File -FilePath "available_m0ha.txt" -Append
        }
        else {
            Write-Host "[!] @$user -> CONNECTION ERROR" -ForegroundColor Yellow
        }
    }
}

Show-Header
$len = Read-Host "Enter handle length (e.g. 4)"
$num = Read-Host "How many handles to check?"

Write-Host "`n[!] Checking... Saved to available_m0ha.txt`n" -ForegroundColor Cyan

for ($i = 1; $i -le $num; $i++) {
    $randomUser = Generate-User -length $len
    Check-User -user $randomUser
    Start-Sleep -Milliseconds 600
}

Write-Host "`nDONE! Thank you for using m0ha tool." -ForegroundColor Magenta
Pause
