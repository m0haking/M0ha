# ==========================================
# Tool: YouTube Handle Generator & Checker
# Developer: m0ha
# Version: 2.0
# ==========================================

function Show-Header {
    Clear-Host
    $header = @"
======================================
    YOUTUBE TOOL BY m0ha [v2.0]
    GENERATE & CHECK HANDLES
======================================
"@
    Write-Host $header -ForegroundColor Cyan
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
        # فحص الرابط بدون تتبع التحويل لضمان الدقة 100%
        $request = Invoke-WebRequest -Uri $url -Method Get -ErrorAction Stop -MaximumRedirection 0
        Write-Host "[-] @$user -> مأخوذ (Taken)" -ForegroundColor Red
    }
    catch {
        if ($_.Exception.Response.StatusCode -eq "NotFound") {
            Write-Host "[+] @$user -> متاح (Available) !!!" -ForegroundColor Green
            # حفظ المتاح في ملف نصي تلقائياً
            "@$user" | Out-File -FilePath "available_m0ha.txt" -Append
        }
        else {
            Write-Host "[!] @$user -> خطأ في الشبكة" -ForegroundColor Yellow
        }
    }
}

# --- تشغيل البرنامج ---
Show-Header

$length = Read-Host "أدخل طول اليوزر (مثلاً 4 أو 5)"
$count = Read-Host "كم عدد اليوزرات التي تريد توليدها وفحصها؟"

Write-Host "`n[!] جاري العمل.. سيتم حفظ المتاح في ملف available_m0ha.txt`n" -ForegroundColor Cyan

for ($i = 1; $i -le $count; $i++) {
    $randomUser = Generate-User -length $length
    Check-User -user $randomUser
    
    # تأخير بسيط (نصف ثانية) لتجنب حظر الآي بي من يوتيوب
    Start-Sleep -Milliseconds 500
}

Write-Host "`n======================================" -ForegroundColor Cyan
Write-Host "تم الانتهاء! شكراً لاستخدام أداة m0ha" -ForegroundColor Magenta
Write-Host "======================================" -ForegroundColor Cyan
Pause
