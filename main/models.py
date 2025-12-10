from django.db import models


class Accommodation(models.Model):
    TITLE_MAX = 200

    title = models.CharField(max_length=TITLE_MAX)
    description = models.TextField(blank=True)
    price = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)
    image = models.CharField(max_length=500, blank=True, help_text='Path or URL to an image')
    featured = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title


class Event(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField(blank=True)
    date = models.DateField(null=True, blank=True)
    location = models.CharField(max_length=250, blank=True)
    price = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)

    def __str__(self):
        return self.title


class Transport(models.Model):
    title = models.CharField(max_length=200)
    description = models.TextField(blank=True)
    capacity = models.PositiveIntegerField(null=True, blank=True)
    price_per_hour = models.DecimalField(max_digits=10, decimal_places=2, null=True, blank=True)

    def __str__(self):
        return self.title
