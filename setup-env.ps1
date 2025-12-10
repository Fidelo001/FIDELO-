<#
  setup-env.ps1
  Helpers to create a virtual environment and install requirements on Windows PowerShell.

  Usage:
    Open PowerShell in the project root and run:
      .\setup-env.ps1

  The script will:
    - set a permissive execution policy for the session
    - remove any partial `.venv` folder
    - create a new `.venv` using the active `python` on PATH
    - upgrade pip inside the venv
    - install packages from `requirements.txt`
    - print the commands to activate the venv and run the server

  Note: Activation must be performed in the interactive shell; the script cannot source the Activate.ps1 for you.
#>

Write-Host "Setting execution policy for this session (RemoteSigned)..." -ForegroundColor Cyan
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process -Force

if (Test-Path -Path .\.venv) {
    Write-Host "Removing existing .venv (if partially created)..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force .\.venv
}

Write-Host "Creating virtual environment (.venv) with: $(Get-Command python).Path" -ForegroundColor Cyan
python -m venv .venv

if ($LASTEXITCODE -ne 0) {
    Write-Host "python -m venv failed. Try creating with --without-pip and installing pip manually." -ForegroundColor Red
    exit 1
}

Write-Host "Upgrading pip inside the venv..." -ForegroundColor Cyan
& .\.venv\Scripts\python -m pip install --upgrade pip setuptools wheel

if (Test-Path -Path requirements.txt) {
    Write-Host "Installing requirements from requirements.txt..." -ForegroundColor Cyan
    & .\.venv\Scripts\python -m pip install -r requirements.txt
} else {
    Write-Host "No requirements.txt found. Skipping install." -ForegroundColor Yellow
}

Write-Host "\nDone. Next steps:" -ForegroundColor Green
Write-Host "1) Activate the venv in this PowerShell session:" -NoNewline; Write-Host "  . .\\.venv\\Scripts\\Activate.ps1" -ForegroundColor Cyan
Write-Host "2) Run migrations (if not already run):" -NoNewline; Write-Host "  python manage.py migrate" -ForegroundColor Cyan
Write-Host "3) Start the development server:" -NoNewline; Write-Host "  python manage.py runserver" -ForegroundColor Cyan
Write-Host "\nIf you run into ensurepip/network issues: try 'python -m venv .venv --without-pip' then install pip via get-pip.py." -ForegroundColor Yellow
