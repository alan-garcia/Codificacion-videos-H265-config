$sourcePath = "C:\ruta\de\videos"
$destinationPath = "C:\ruta\de\salida"

# Extensiones de videos admitidos
$videoExtensions = ".mp4", ".avi", ".mkv", ".wmv"

# Busca todos los vídeos con esas extensiones en la ruta de origen
$videos = Get-ChildItem -Path $sourcePath -Recurse | Where-Object {
    $videoExtensions -contains $_.Extension.ToLower()
}

$totalVideos = $videos.Count
$current = 0

foreach ($video in $videos) {
    $current++

    $inputFile = $video.FullName
    $relativePath = $video.FullName.Substring($sourcePath.Length).TrimStart('\','/')

    $outputPath = Join-Path $destinationPath $relativePath
    $outputDir = Split-Path $outputPath -Parent

    # Crea una carpeta de destino si no existe
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    
    $outputFile = [System.IO.Path]::Combine($outputDir, "$($video.BaseName)$($video.Extension)")

    # Muestra el progreso con el nº total de videos a procesar
    $percent = [math]::Round(($current / $totalVideos) * 100, 2)
    Write-Host "`n[$current/$totalVideos] ($percent%) Convirtiendo:" -ForegroundColor DarkGray
    Write-Host "  Entrada: $inputFile" -ForegroundColor Cyan
    Write-Host "  Salida: $outputFile" -ForegroundColor Yellow

    # Configurar la codificación y calidad de video de salida con ffmpeg
    $ffmpegConfig = @(
        "-hide_banner"
        "-y"
        "-i", "$inputFile"
        "-c:v", "libx265"
        "-preset", "medium"
        "-crf", "18"
        "-c:a", "copy"
        "$outputFile"
    )

    # Muestra únicamente la información de audio y video durante el proceso de codificación, ignorando el resto de información
    & ffmpeg @ffmpegConfig 2>&1 | ForEach-Object {
        if ($_ -match "Output #0" -or $_ -match "Stream #0") {
            Write-Host $_
        }
        elseif ($_ -match "frame=") {
            # Sobrescribe la línea que muestra del proceso de codificación (barra de progreso)
            Write-Host "`r$_" -NoNewline
        }
    }

    # Muestra un mensaje después de terminar de codificar cada video
    Write-Host "`n--- Archivo $current de $totalVideos completado ---`n" -ForegroundColor Green
}
