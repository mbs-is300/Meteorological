from .models import City, Users, Users_Cities
from rest_framework import viewsets
from rest_framework import permissions
from .serializers import CitiesSerializer, UsersSerializer, Users_CitiesSerializer

class CityViewSet(viewsets.ModelViewSet):
    queryset = City.objects.all()
    serializer_class = CitiesSerializer
    permission_classes = [permissions.IsAuthenticated]

class UsersViewSet(viewsets.ModelViewSet):
    queryset = Users.objects.all()
    serializer_class = UsersSerializer
    permission_classes = [permissions.IsAuthenticated]

class Users_CitiesViewSet(viewsets.ModelViewSet):
    queryset = Users_Cities.objects.all()
    serializer_class = Users_CitiesSerializer
    permission_classes = [permissions.IsAuthenticated]