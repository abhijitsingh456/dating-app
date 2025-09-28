# src/config/settings/dev.py
# from .base import DATABASES, INSTALLED_APPS, MIDDLEWARE, TEMPLATES, env

DEBUG = True
ALLOWED_HOSTS = ["*"]

EMAIL_BACKEND = "django.core.mail.backends.console.EmailBackend"
