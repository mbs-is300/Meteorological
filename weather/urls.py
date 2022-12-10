from django.contrib import admin
from django.urls import path, include
from . import views
from rest_framework import routers
from rest_framework.routers import DefaultRouter

router = routers.DefaultRouter()
router.register(r'city', views.CityViewSet)
router.register(r'users', views.UsersViewSet)
router.register(r'users_cities', views.Users_CitiesViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('weather-auth/', include('rest_framework.urls'))
]