from django.urls import path
from . import views

app_name = 'calculator'

urlpatterns = [
    path('', views.calculator, name='index'),
    path('api/calculate/', views.calculate, name='calculate'),
]
