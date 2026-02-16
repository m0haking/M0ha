# ==========================================
# Tool: YouTube Handle Master
# Developer: m0ha
# Version: 3.0
# ==========================================

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
        # استخدام Invoke-WebRequest لفحص دقيق للحالة 404
        $request = Invoke-WebRequest -Uri $url -Method Get -ErrorAction Stop -MaximumRedirection 0
        Write-Host "[-] @$user -> مأخوذ (Taken)" -ForegroundColor Red
    }
    catch {
        if ($_.Exception.Response.StatusCode -eq "NotFound") {
            Write-Host "[+] @$user -> متاح (Available) !!!" -ForegroundColor Green
            "@$user" | Out-File -FilePath "available_m0ha.txt" -Append
        }
        else {
            Write-Host "[!] @$user -> خطأ في الشبكة" -ForegroundColor Yellow
        }
    }
}

# --- البرنامج الرئيسي ---
Show-Header

$len = Read-Host "أدخل طول اليوزر المطلوب (مثلاً 4)"
$num = Read-Host "كم عدد اليوزرات التي تريد فحصها؟"

Write-Host "`n[!] جاري الفحص.. المتاح سيُحفظ في available_m0ha.txt`n" -ForegroundColor Cyan

for ($i = 1; $i -le $num; $i++) {
    $randomUser = Generate-User -length $len
    Check-User -user $randomUser
    # تأخير 600 مللي ثانية لتفادي الحظر
    Start-Sleep -Milliseconds 600
}

Write-Host "`nتم الانتهاء! شكراً لثقتك ببرمجيات m0ha" -ForegroundColor Magenta
Pause
