# Generated by Django 4.1.4 on 2022-12-08 16:37

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('weather', '0002_city_centercoordinate'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='city',
            name='centerCoordinate',
        ),
    ]
