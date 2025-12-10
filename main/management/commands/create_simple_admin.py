from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model


class Command(BaseCommand):
    help = 'Create a simple superuser non-interactively (for development).'

    def add_arguments(self, parser):
        parser.add_argument('--username', default='admin', help='Admin username')
        parser.add_argument('--email', default='admin@example.com', help='Admin email')
        parser.add_argument('--password', default='adminpass', help='Admin password')

    def handle(self, *args, **options):
        User = get_user_model()
        username = options['username']
        email = options['email']
        password = options['password']

        if User.objects.filter(username=username).exists():
            self.stdout.write(self.style.WARNING(f'User "{username}" already exists.'))
            return

        User.objects.create_superuser(username=username, email=email, password=password)
        self.stdout.write(self.style.SUCCESS(f'Superuser "{username}" created with provided password.'))
