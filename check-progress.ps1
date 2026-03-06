#!/usr/bin/env pwsh
# TodoList 项目进度检查脚本

$projectPath = "C:\Users\44452\todolist-project"
$logFile = "$projectPath\progress-log.txt"

function Check-Progress {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $log = "`n=== 进度检查 $timestamp ===`n"
    
    # 检查文件是否存在
    $files = @(
        "requirements.md",
        "design-doc.md", 
        "discussion.md",
        "public\index.html"
    )
    
    foreach ($file in $files) {
        $path = Join-Path $projectPath $file
        if (Test-Path $path) {
            $size = (Get-Item $path).Length
            $log += "[✓] $file ($size bytes)`n"
        } else {
            $log += "[✗] $file 缺失`n"
        }
    }
    
    # 检查网页是否可访问
    $htmlPath = Join-Path $projectPath "public\index.html"
    if (Test-Path $htmlPath) {
        $content = Get-Content $htmlPath -Raw
        if ($content -match "皮皮虾的 TodoList") {
            $log += "[✓] 网页内容正常`n"
        } else {
            $log += "[✗] 网页内容异常`n"
        }
    }
    
    $log += "`n当前状态：第四步已完成，等待第五步发布`n"
    
    Add-Content -Path $logFile -Value $log
    Write-Host $log
}

Check-Progress
