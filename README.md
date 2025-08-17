# Codificación videos a H.265 config

Script en **PowerShell** que permite convertir múltiples archivos de video usando **ffmpeg**, manteniendo la misma extensión de salida, y mostrando una barra de progreso con información del proceso.

## ✨ Características
- Convierte videos en lote desde una carpeta de origen a una carpeta de destino, manteniendo la misma estructura de carpetas y extensiones de archivos.
- Soporta múltiples extensiones de video: `.mp4`, `.avi`, `.mkv`, `.wmv`.
- Muestra el progreso (porcentaje y archivo actual).
- Codificación de video con **libx265** (H.265) y copia de audio.

## ⚙️ Requisitos
- **Windows PowerShell 5.1** o **PowerShell 7+**
- Instalar [ffmpeg](https://ffmpeg.org/download.html)

## 🚀 Uso
1. Modifica el script, y establece la carpeta de origen y destino:
   ```powershell
   $sourcePath = "C:\ruta\de\videos"
   $destinationPath = "C:\ruta\de\salida"

2. Opcionalmente, puedes modificar las extensiones de video admitidas a tu libre elección:
   ```powershell
   $videoExtensions = ".mp4", ".avi", ".mkv", ".wmv"
