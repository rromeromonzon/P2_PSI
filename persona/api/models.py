from django.db import models

# Create your models here.

class Persona(models.Model):
    nombre = models.CharField(max_length=100)
    apellido = models.CharField(max_length=100)
    email = models.EmailField()

    class Meta:
        ordering = ['id']  # Ordenar por id

    def __str__(self):
        return f"{self.nombre} {self.apellido}"
    

