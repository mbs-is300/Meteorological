from django.db import models
from jsonfield import JSONField

# Create your models here.
class City(models.Model):
    cityID      = models.IntegerField()
    regionID    = models.IntegerField()
    nameAR      = models.CharField(max_length=50)
    nameEN      = models.CharField(max_length=50)
    latitude    = models.CharField(max_length=50)
    longitude   = models.CharField(max_length=50)

    def __str__(self):
        return self.cityID


class Users(models.Model):
    user_name = models.CharField(max_length=50)
    password = models.CharField(max_length=50)
    is_admin = bool()

class Users_Cities(models.Model):
    user_id   = models.IntegerField()
    cityID   = models.IntegerField()
    regionID    = models.IntegerField()
    nameAR    = models.CharField(max_length=50)
    nameEN    = models.CharField(max_length=50)
    latitude  = models.CharField(max_length=50)
    longitude = models.CharField(max_length=50)

