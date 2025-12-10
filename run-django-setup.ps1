<#
  run-django-setup.ps1
  Runs Django migrations, creates a simple admin, seeds sample data and optionally starts the dev server.

  Usage examples (from project root):
    # Run migrations, create admin, seed data and print next steps
    .\run-django-setup.ps1

    # Do the same and start the dev server in a new process/window
    .\run-django-setup.ps1 -StartServer

  Notes:
  - If a `.venv` exists, the script will use `.\.venv\Scripts\python.exe` to run Django commands.
  - If no `.venv` exists it will fall back to the `python` on PATH.
  - The script only automates development setup. For production follow secure practices.
#>

param(
    [switch]$StartServer
)

Write-Host "Setting execution policy for this session (RemoteSigned)..." -ForegroundColor Cyan
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $scriptDir

if (Test-Path -Path .\.venv\Scripts\python.exe) {
    $python = Join-Path $scriptDir '.\.venv\Scripts\python.exe'
    Write-Host "Using venv python: $python" -ForegroundColor Green
} else {
    # Prefer an active conda environment if available
    if ($env:CONDA_PREFIX) {
        $condaPython = Join-Path $env:CONDA_PREFIX 'python.exe'
        if (Test-Path $condaPython) {
            $python = $condaPython
            Write-Host "Using conda environment python: $python" -ForegroundColor Green
        }
    }

    # Fallback to a named conda env path if present (common Miniconda location)
    if (-not $python) {
        $fallback = Join-Path $env:USERPROFILE 'miniconda3\envs\fidelo\python.exe'
        if (Test-Path $fallback) {
            $python = $fallback
            Write-Host "Using fallback conda env python: $python" -ForegroundColor Green
        }
    }

    if (-not $python) {
        $python = 'python'
        Write-Host "No .venv or conda env detected — using system python on PATH." -ForegroundColor Yellow
    }
}

Write-Host "Installing/ensuring requirements (if requirements.txt exists)..." -ForegroundColor Cyan
if (Test-Path requirements.txt) {
    & $python -m pip install --upgrade pip setuptools wheel
    & $python -m pip install -r requirements.txt
} else {
    Write-Host "No requirements.txt found — skipping pip install." -ForegroundColor Yellow
}

Write-Host "Making migrations for 'main' app..." -ForegroundColor Cyan
& $python manage.py makemigrations main

Write-Host "Applying migrations..." -ForegroundColor Cyan
& $python manage.py migrate

Write-Host "Creating simple admin user (development) if it does not exist..." -ForegroundColor Cyan
& $python manage.py create_simple_admin --username admin --email admin@example.com --password adminpass

Write-Host "Seeding sample data (ORM-based)..." -ForegroundColor Cyan
& $python manage.py seed_sample_data

if ($StartServer) {
    Write-Host "Starting development server in a new process..." -ForegroundColor Green
    # Launch a new PowerShell window that runs the env python to start Django
    $escapedPython = $python -replace "'","''"
    $cmd = "& '$escapedPython' manage.py runserver"
    Start-Process powershell -ArgumentList ('-NoExit','-Command', $cmd) -WorkingDirectory $scriptDir
    Write-Host "Dev server started in a new PowerShell window. Open http://127.0.0.1:8000/" -ForegroundColor Green
} else {
    Write-Host "Setup complete. To start the server run:" -ForegroundColor Green
    Write-Host "  python manage.py runserver" -ForegroundColor Cyan
}
Write-Host "All steps finished." -ForegroundColor Cyan