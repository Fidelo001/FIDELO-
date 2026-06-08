# Calculator Integration Guide

## Overview
A simple calculator app has been added to your Django project with both backend and frontend functionality.

## Installation Steps

### 1. Add Calculator App to Django Settings
Open your `settings.py` file and add `'calculator'` to `INSTALLED_APPS`:

```python
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    # ... your other apps
    'calculator',  # Add this line
]
```

### 2. Include Calculator URLs
Open your main `urls.py` file and add the calculator URLs:

```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    # ... your other URLs
    path('calculator/', include('calculator.urls')),  # Add this line
]
```

### 3. Create Templates Directory
If the templates directory doesn't exist, create it:

```bash
mkdir -p calculator/templates/calculator
```

### 4. Run Server
```bash
python manage.py runserver
```

### 5. Access Calculator
Open your browser and navigate to:
```
http://127.0.0.1:8000/calculator/
```

## Features

✅ **Basic Operations**
- Addition
- Subtraction
- Multiplication
- Division
- Power
- Square Root

✅ **User Interface**
- Clean, modern design with gradient background
- Responsive layout (works on mobile & desktop)
- Operation buttons with visual feedback
- Result display with error handling

✅ **Additional Features**
- Calculation history (last 10 calculations)
- Error handling for edge cases (division by zero, etc.)
- Keyboard support (Enter to calculate)
- CSRF protection for security

## File Structure

```
calculator/
├── __init__.py
├── apps.py
├── views.py
├── urls.py
└── templates/
    └── calculator/
        └── calculator.html
```

## Backend API

### Endpoint: POST `/calculator/api/calculate/`

**Request Body:**
```json
{
    "operation": "add",
    "num1": 10,
    "num2": 5
}
```

**Response:**
```json
{
    "result": 15
}
```

**Supported Operations:**
- `add`
- `subtract`
- `multiply`
- `divide`
- `power`
- `square_root`

## Customization

You can easily customize:
- **Colors**: Edit the gradient colors in the CSS
- **Operations**: Add more operations in `views.py` and update the frontend
- **History Limit**: Change `if calculationHistory.length > 10` in the JavaScript
- **Styling**: Modify the CSS in the HTML template

## Security Notes

- CSRF protection is implemented
- Input validation is performed on both frontend and backend
- Error handling prevents malicious input attacks

## Troubleshooting

**Calculator page not found?**
- Ensure you added `'calculator'` to `INSTALLED_APPS`
- Verify the URL pattern in main `urls.py`

**Styling looks broken?**
- Clear browser cache (Ctrl+Shift+Delete or Cmd+Shift+Delete)
- Check that the HTML file is properly served

**Operations not working?**
- Check browser console for JavaScript errors (F12)
- Verify CSRF token is being sent correctly
- Check Django logs for backend errors

Enjoy your calculator! 🧮
