# Generated by Django 4.1.4 on 2022-12-09 15:58

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('weather', '0018_alter_city_latitude_alter_city_longitude'),
    ]

    operations = [
        migrations.CreateModel(
            name='Users',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_name', models.CharField(max_length=50)),
                ('password', models.CharField(max_length=50)),
            ],
        ),
        migrations.CreateModel(
            name='Users_Cities',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_id', models.IntegerField()),
                ('city_id', models.IntegerField()),
            ],
        ),
    ]
