# Generated by Django 4.1.4 on 2022-12-09 18:34

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('weather', '0020_users_cities_latitude_users_cities_longitude_and_more'),
    ]

    operations = [
        migrations.RenameField(
            model_name='users_cities',
            old_name='city_id',
            new_name='cityID',
        ),
        migrations.AddField(
            model_name='users_cities',
            name='regionID',
            field=models.IntegerField(default=0),
            preserve_default=False,
        ),
    ]
