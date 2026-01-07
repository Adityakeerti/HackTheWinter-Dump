@echo off
setlocal EnableDelayedExpansion

echo.
echo ==============================================================
echo   Campus Intelligence System - Dependency Installer
echo   For Windows (Fresh PC Setup)
echo ==============================================================
echo.
echo This script will install all project dependencies.
echo Make sure you have already installed:
echo   [x] Python 3.10+
echo   [x] Node.js 18+
echo   [x] Java JDK 17+ (for Spring Boot backends)
echo.
echo Press any key to continue or Ctrl+C to cancel...
pause >nul

echo.
echo ==============================================================
echo   STEP 1/5: Checking Prerequisites
echo ==============================================================

REM Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python is not installed or not in PATH!
    echo         Please install Python from https://python.org
    echo         IMPORTANT: Check "Add Python to PATH" during installation!
    pause
    exit /b 1
) else (
    for /f "tokens=2" %%i in ('python --version 2^>^&1') do echo [OK] Python %%i found
)

REM Check pip
pip --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] pip is not installed!
    pause
    exit /b 1
) else (
    echo [OK] pip found
)

REM Check Node.js
node --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js is not installed or not in PATH!
    echo         Please install Node.js from https://nodejs.org
    pause
    exit /b 1
) else (
    for /f "tokens=1" %%i in ('node --version 2^>^&1') do echo [OK] Node.js %%i found
)

REM Check npm
npm --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] npm is not installed!
    pause
    exit /b 1
) else (
    for /f "tokens=1" %%i in ('npm --version 2^>^&1') do echo [OK] npm %%i found
)

REM Check Java
java -version >nul 2>&1
if errorlevel 1 (
    echo [WARNING] Java is not installed or not in PATH!
    echo           Spring Boot backends won't work without Java 17+
    echo           Download from: https://adoptium.net/
) else (
    echo [OK] Java found
)

echo.
echo ==============================================================
echo   STEP 2/5: Installing Python Dependencies (Agent1)
echo ==============================================================

if exist "Agent1\requirements.txt" (
    echo Installing Agent1 dependencies...
    cd Agent1
    pip install -r requirements.txt
    if errorlevel 1 (
        echo [WARNING] Some Agent1 dependencies may have failed
    ) else (
        echo [OK] Agent1 dependencies installed
    )
    cd ..
) else (
    echo [SKIP] Agent1/requirements.txt not found
)

echo.
echo ==============================================================
echo   STEP 3/5: Installing Python Dependencies (Backend-OCR)
echo ==============================================================

if exist "backend-ocr\requirements.txt" (
    echo Installing backend-ocr dependencies...
    cd backend-ocr
    pip install -r requirements.txt
    if errorlevel 1 (
        echo [WARNING] Some backend-ocr dependencies may have failed
    ) else (
        echo [OK] backend-ocr dependencies installed
    )
    cd ..
) else (
    echo [SKIP] backend-ocr/requirements.txt not found
)

echo.
echo ==============================================================
echo   STEP 4/5: Installing Python Dependencies (Backend-Lib)
echo ==============================================================

if exist "backend-lib\requirements.txt" (
    echo Installing backend-lib dependencies...
    cd backend-lib
    pip install -r requirements.txt
    if errorlevel 1 (
        echo [WARNING] Some backend-lib dependencies may have failed
    ) else (
        echo [OK] backend-lib dependencies installed
    )
    cd ..
) else (
    echo [SKIP] backend-lib/requirements.txt not found
)

echo.
echo ==============================================================
echo   STEP 5/5: Installing Node.js Dependencies
echo ==============================================================

REM Landing Page
if exist "Landing\package.json" (
    echo.
    echo Installing Landing page dependencies...
    cd Landing
    call npm install
    if errorlevel 1 (
        echo [WARNING] Some Landing dependencies may have failed
    ) else (
        echo [OK] Landing dependencies installed
    )
    cd ..
) else (
    echo [SKIP] Landing/package.json not found
)

REM Frontend Web
if exist "frontend\web\package.json" (
    echo.
    echo Installing frontend/web dependencies...
    cd frontend\web
    call npm install
    if errorlevel 1 (
        echo [WARNING] Some frontend/web dependencies may have failed
    ) else (
        echo [OK] frontend/web dependencies installed
    )
    cd ..\..
) else (
    echo [SKIP] frontend/web/package.json not found
)

echo.
echo ==============================================================
echo   SETUP COMPLETE!
echo ==============================================================
echo.
echo Next Steps:
echo.
echo   1. Create configuration files from .example templates:
echo      - backend-ai/src/main/resources/application.yml
echo      - backend-chat/src/main/resources/application.properties
echo      - backend-meeting/src/main/resources/application.properties  
echo      - Agent1/.env
echo.
echo   2. Update the config files with your MySQL password and API keys
echo.
echo   3. Import the database schema:
echo      mysql -u root -p connect_college ^< database/connect_college_schema.sql
echo.
echo   4. Run start_servers.bat to start all backend services
echo.
echo   5. Start frontends with:
echo      cd Landing ^&^& npm run dev
echo      cd frontend/web ^&^& npm run dev
echo.
echo ==============================================================
echo.
pause
