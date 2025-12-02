
# Android emulator setup + build + install + launch (no Android Studio required)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# 0) Ensure JDK 17 is used
$java = Get-ChildItem "C:\Program Files\Eclipse Adoptium\" -Recurse -Filter java.exe -ErrorAction SilentlyContinue | Where-Object { $_.FullName -like "*jdk-17*bin\java.exe" } | Select-Object -First 1
if (-not $java) { throw "JDK 17 not found. Install Eclipse Temurin 17 first." }
$Env:JAVA_HOME = Split-Path -Path (Split-Path -Path $java.FullName -Parent) -Parent
$Env:PATH = (Split-Path $java.FullName -Parent) + ";" + $Env:PATH
java -version

# 1) Minimal Android SDK + cmdline-tools
$Env:ANDROID_SDK_ROOT = "$HOME\Android\sdk"
$cmdline = "$Env:ANDROID_SDK_ROOT\cmdline-tools\latest"
New-Item -ItemType Directory -Force -Path $cmdline | Out-Null
$zip = "$env:TEMP\cmdline-tools.zip"
if (-not (Test-Path "$cmdline\bin\sdkmanager.bat")) {
  Invoke-WebRequest -Uri "https://dl.google.com/android/repository/commandlinetools-win-11076708_latest.zip" -OutFile $zip
  Expand-Archive -Force $zip "$Env:ANDROID_SDK_ROOT\cmdline-tools"
  Copy-Item "$Env:ANDROID_SDK_ROOT\cmdline-tools\cmdline-tools\*" -Destination $cmdline -Recurse -Force
  Remove-Item "$Env:ANDROID_SDK_ROOT\cmdline-tools\cmdline-tools" -Recurse -Force
  Remove-Item $zip -Force
}
$Env:PATH = "$cmdline\bin;$Env:ANDROID_SDK_ROOT\platform-tools;$Env:ANDROID_SDK_ROOT\emulator;$Env:PATH"

# 2) Accept licenses and install required packages (large downloads here)
cmd /c "(for /l %i in (1,1,200) do @echo y) | sdkmanager --licenses"
sdkmanager "platform-tools" "emulator" "platforms;android-34" "build-tools;34.0.0" "system-images;android-34;google_apis;x86_64"

# 3) Create an Android 14 (API 34) emulator
$avdName = "api34RoomScan"
$existing = & avdmanager list avd | Select-String $avdName
if (-not $existing) {
  avdmanager create avd -n $avdName -k "system-images;android-34;google_apis;x86_64" -d pixel_6 -g google_apis
}

# 4) Start emulator with safe defaults
$emuArgs = "-avd $avdName -no-snapshot -no-boot-anim -gpu swiftshader_indirect -accel on -netdelay none -netspeed full"
Start-Process "$Env:ANDROID_SDK_ROOT\emulator\emulator.exe" -ArgumentList $emuArgs

# 5) Wait for boot completion
& adb start-server
adb wait-for-device
$max = 120
for ($i=0; $i -lt $max; $i++) {
  $boot = adb shell getprop sys.boot_completed 2>$null
  if ($boot -match "1") { break }
  Start-Sleep -Seconds 3
}
if ($i -ge $max) { throw "Emulator failed to boot in time." }

# 6) Local Gradle 8.7 (no winget), generate wrapper, build + install
$gradleZip = "$env:TEMP\gradle-8.7-bin.zip"
$gradleHome = "$HOME\gradle\gradle-8.7"
if (-not (Test-Path "$gradleHome\bin\gradle.bat")) {
  New-Item -ItemType Directory -Force -Path "$HOME\gradle" | Out-Null
  Invoke-WebRequest "https://services.gradle.org/distributions/gradle-8.7-bin.zip" -OutFile $gradleZip
  Expand-Archive -Force $gradleZip "$HOME\gradle"
  Remove-Item $gradleZip -Force
}
& "$gradleHome\bin\gradle.bat" wrapper --gradle-version 8.7

.\gradlew :app:installDebug --no-daemon

# 7) Launch the app
adb shell monkey -p com.example.roomscanpro -c android.intent.category.LAUNCHER 1
Write-Host "Done. App launched on the emulator."