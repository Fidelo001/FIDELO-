from django.core.management.base import BaseCommand
from django.db import OperationalError


class Command(BaseCommand):
    help = 'Seed sample data into the database (uses Django ORM; safe after migrations).'

    def handle(self, *args, **options):
        self.stdout.write('Seeding sample data using Django ORM...')
        try:
            from main.models import Accommodation, Event, Transport

            if Accommodation.objects.exists() or Event.objects.exists() or Transport.objects.exists():
                self.stdout.write(self.style.WARNING('Some sample data already exists; skipping insertion.'))
                return

            Accommodation.objects.create(
                title='Sample Villa',
                description='A beautiful villa for your stay.',
                price=299.00,
                image='assets/luxury-house.jpg',
                featured=True,
            )
            Accommodation.objects.create(
                title='Cozy Cottage',
                description='Comfortable and warm cottage.',
                price=99.00,
                image='assets/house-1.jpg',
                featured=False,
            )

            Event.objects.create(
                title='Summer Gala',
                description='An exclusive evening event.',
                date='2026-07-15',
                location='Main Hall',
                price=150.00,
            )

            Transport.objects.create(
                title='Ferrari Experience',
                description='Drive a luxury car.',
                capacity=2,
                price_per_hour=250.00,
            )

            self.stdout.write(self.style.SUCCESS('Sample data seeded using ORM.'))

        except OperationalError as exc:
            self.stdout.write(self.style.ERROR('Database error when seeding sample data: ' + str(exc)))
            self.stdout.write(self.style.ERROR('This usually means migrations have not been applied. Run:'))
            self.stdout.write(self.style.ERROR('  python manage.py makemigrations'))
            self.stdout.write(self.style.ERROR('  python manage.py migrate'))
            return
