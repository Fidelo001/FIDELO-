from django.shortcuts import render


def home(request):
    """Render the homepage using the existing static assets and template."""
    return render(request, 'main/index.html')
