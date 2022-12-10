from .models import City, Users, Users_Cities 
from rest_framework import serializers

class CitiesSerializer(serializers.ModelSerializer):
    class Meta:
        model = City
        fields = '__all__'

class UsersSerializer(serializers.ModelSerializer):
    class Meta:
        model = Users
        fields = '__all__'

class Users_CitiesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Users_Cities
        fields = '__all__'