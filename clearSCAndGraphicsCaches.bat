@echo off
CLS

echo Clearing frontend config. . . .
rmdir /s /q "%~dp0..\LIVE\USER\Client\0\frontend" > nul 2>&1
rmdir /s /q "%~dp0..\PTU\USER\Client\0\frontend" > nul 2>&1
rmdir /s /q "%~dp0..\EPTU\USER\Client\0\frontend" > nul 2>&1
rmdir /s /q "%~dp0..\TECH-PREVIEW\USER\Client\0\frontend" > nul 2>&1
rmdir /s /q "%~dp0..\HOTFIX\USER\Client\0\frontend" > nul 2>&1

echo Removing Star Citizen Shader Caches...
rmdir /s /q "%LOCALAPPDATA%\Star Citizen\" > nul 2>&1
rmdir /s /q "%~dp0..\LIVE\USER\Client\0\shaders" > nul 2>&1
rmdir /s /q "%~dp0..\PTU\USER\Client\0\shaders" > nul 2>&1
rmdir /s /q "%~dp0..\EPTU\USER\Client\0\shaders" > nul 2>&1
rmdir /s /q "%~dp0..\TECH-PREVIEW\USER\Client\0\shaders" > nul 2>&1
rmdir /s /q "%~dp0..\HOTFIX\USER\Client\0\shaders" > nul 2>&1

IF EXIST "%LOCALAPPDATA%\NVIDIA" (
	echo.
	IF EXIST "%LOCALAPPDATA%\NVIDIA\DXCache" (
		echo Removing NVidia DirectX Cache...
		rmdir /s /q "%LOCALAPPDATA%\NVIDIA\DXCache" > nul 2>&1
	)
	IF EXIST "%LOCALAPPDATA%\NVIDIA\GLCache" (
		echo Removing NVidia OpenGL Cache...
		rmdir /s /q "%LOCALAPPDATA%\NVIDIA\GLCache" > nul 2>&1
	)
)

IF EXIST "%LOCALAPPDATA%\AMD" (
	echo.
	IF EXIST "%LOCALAPPDATA%\AMD\Dx*Cache" (
		echo Removing AMD DirectX Cache...
		rmdir /s /q "%LOCALAPPDATA%\AMD\DxCache" > nul 2>&1
		rmdir /s /q "%LOCALAPPDATA%\AMD\DX9Cache" > nul 2>&1
	)
	IF EXIST "%LOCALAPPDATA%\AMD\*GL*Cache" (
		echo Removing AMD OpenGL Cache...
		rmdir /s /q "%LOCALAPPDATA%\AMD\GLCache" > nul 2>&1
		rmdir /s /q "%LOCALAPPDATA%\AMD\OglpCache" > nul 2>&1
	)
	IF EXIST "%LOCALAPPDATA%\AMD\VkCache" (
		echo Removing AMD Vulkan Cache...
		rmdir /s /q "%LOCALAPPDATA%\AMD\VkCache" > nul 2>&1
	)
)

echo.
echo Removing Star Citizen Backup Logs...
rmdir /s /q "%~dp0..\LIVE\logbackups" > nul 2>&1
rmdir /s /q "%~dp0..\PTU\logbackups" > nul 2>&1
rmdir /s /q "%~dp0..\EPTU\logbackups" > nul 2>&1
rmdir /s /q "%~dp0..\TECH-PREVIEW\logbackups" > nul 2>&1
rmdir /s /q "%~dp0..\HOTFIX\logbackups" > nul 2>&1
