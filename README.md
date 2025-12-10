# FIDELO - Accommodation Project

Short project summary
- Simple accommodation listing site scaffolded with Django (4.2) and a polished front-end.
- Features: home page, booking modal (demo PayPal), admin-managed `Accommodation`, `Event`, and `Transport` models.

Getting started (development)
1. Clone the repository:

```powershell
git clone https://github.com/Fidelo001/FIDELO-.git
cd FIDELO-
```

2. Create & activate the Python environment (recommended with Conda):

```powershell
conda create -n fidelo python=3.11 -y
conda activate fidelo
python -m pip install -r requirements.txt
```

3. Run migrations and seed sample data:

```powershell
python manage.py makemigrations
python manage.py migrate
python manage.py seed_sample_data
```

4. Create or update admin user (dev):

```powershell
python manage.py create_simple_admin --username admin --email admin@example.com --password adminpass
# or interactively
python manage.py createsuperuser
```

5. Start the dev server (local):

```powershell
python manage.py runserver
# Open http://127.0.0.1:8000/ and admin at /admin/
```

Sharing your work
- LAN: http://<your-local-ip>:8000/ (e.g. http://192.168.0.103:8000/) — ensure firewall allows port 8000 and the viewer is on the same network.
- Temporary public tunnels: use `npx localtunnel --port 8000` (temporary) or `ngrok` with an authtoken for reliable HTTPS tunnels.

Important notes
- This repo contains development assets and a sample SQLite DB (`db.sqlite3`). Do not use this DB in production.
- Change the admin password and set `DEBUG=False` before publishing.
- Remove or secure any credentials and avoid committing secrets.

Next steps
- (Optional) I can add a `.gitignore` (recommended) to exclude `db.sqlite3`, `ngrok.zip`, `.venv`, and other runtime artifacts.
- (Optional) I can prepare a `Procfile` and deployment notes for Render/Heroku.

---
Project repository: https://github.com/Fidelo001/FIDELO-
