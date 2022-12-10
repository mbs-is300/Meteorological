from django.contrib import admin
from django.urls import path, include
from weather import views
from rest_framework.routers import DefaultRouter

router = DefaultRouter()

urlpatterns = [
    path('admin/', admin.site.urls),
    path('weather/', include('weather.urls')),
    ]
