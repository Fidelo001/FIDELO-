# Django development setup for FIDELO

This project scaffolds a minimal Django app to serve the existing frontend as a template.

Quick start (Windows PowerShell):

1. Create and activate a virtual environment
```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

2. Install dependencies
```powershell
pip install -r requirements.txt
```

3. Run migrations and start the dev server
```powershell
python manage.py migrate
python manage.py runserver
```

4. Open http://127.0.0.1:8000/ in your browser.

Notes:
- The project uses `STATICFILES_DIRS = [BASE_DIR]` so the existing `main.css` and `assets/` folder in the repository root are served by Django during development.
- Payment integration in the booking modal is a client-side demo (PayPal sandbox). For production, implement server-side order creation and verification.
- Replace the `SECRET_KEY` in `fidelosite/settings.py` before deploying to production and set `DEBUG = False` and `ALLOWED_HOSTS` accordingly.

Additional backend steps (models, admin, and sample data)

1. Create database schema (makemigrations + migrate):
```powershell
python manage.py makemigrations
python manage.py migrate
```

2. Create a simple admin user (non-interactive demo):
```powershell
# Creates superuser 'admin' with password 'adminpass' by default
python manage.py create_simple_admin --username admin --email admin@example.com --password adminpass
```

3. Seed sample data using raw SQL (the command executes raw INSERTs via Django's DB cursor):
```powershell
python manage.py seed_sample_data
```

4. Open the admin interface and log in with the credentials created in step 2:
	- Admin site: http://127.0.0.1:8000/admin/

Notes about the sample-data SQL command:
- `seed_sample_data` executes raw SQL against the `main_` app tables. Ensure migrations have been applied first (step 1). It is provided as a small demonstration of mixing raw SQL with Django; for production use Django ORM or fixtures.

