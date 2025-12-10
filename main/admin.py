from django.contrib import admin
from .models import Accommodation, Event, Transport


@admin.register(Accommodation)
class AccommodationAdmin(admin.ModelAdmin):
    list_display = ('title', 'price', 'featured', 'created_at')
    list_filter = ('featured',)
    search_fields = ('title', 'description')


@admin.register(Event)
class EventAdmin(admin.ModelAdmin):
    list_display = ('title', 'date', 'location', 'price')
    search_fields = ('title', 'description', 'location')


@admin.register(Transport)
class TransportAdmin(admin.ModelAdmin):
    list_display = ('title', 'capacity', 'price_per_hour')
    search_fields = ('title', 'description')
