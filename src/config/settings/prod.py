# src/config/settings/prod.py
# from .base import DATABASES, INSTALLED_APPS, MIDDLEWARE, TEMPLATES, env
from .base import env

DEBUG = False

ALLOWED_HOSTS = env.list("DJANGO_ALLOWED_HOSTS", default=["yourdomain.com"])

SECURE_SSL_REDIRECT = True
SESSION_COOKIE_SECURE = True
CSRF_COOKIE_SECURE = True
