#!/bin/bash

# Hacer que el script falle si algún comando falla
set -e

# Configuración inicial para el entorno
echo "Configurando entorno..."

# Crear un entorno virtual para Django
if [ ! -d "env" ]; then
    echo "Creando entorno virtual para Django..."
    python3 -m venv env
fi

# Activar el entorno virtual
source env/bin/activate

# Instalar dependencias de Python (Django y otras)
echo "Instalando dependencias de Python..."
pip install --upgrade pip
pip install -r requirements.txt

# Crear base de datos de Django (si no existe)
echo "Creando base de datos de Django..."
cd persona
python manage.py migrate

# Crear un superusuario si no existe
echo "Comprobando si el superusuario 'alumnodb' existe..."
USER_EXISTS=$(python manage.py shell -c "from django.contrib.auth.models import User; print(User.objects.filter(username='alumnodb').exists())")

if [ "$USER_EXISTS" == "False" ]; then
    echo "Creando superusuario 'alumnodb'..."
    echo "from django.contrib.auth.models import User; User.objects.create_superuser('alumnodb', 'admin@example.com', 'tu_contraseña')" | python manage.py shell
else
    echo "El superusuario 'alumnodb' ya existe."
fi

# Instalar dependencias de Vue.js
echo "Instalando dependencias de Vue.js..."
cd ..
cd tutorial-vue
npm install

# Configuración de CORS para Vue.js en Django
echo "Configurando CORS..."
# Esto depende de que tengas instalado django-cors-headers y las configuraciones correspondientes en settings.py
pip install django-cors-headers

# Agregar CORS_ORIGIN_WHITELIST al archivo settings.py si no está presente
echo "CORS_ORIGIN_WHITELIST = ['${VUE_URL}']" >> ../persona/persona/settings.py

# Instalando dependencias de la base de datos (Neon)
echo "Instalando dependencias de la base de datos..."
pip install psycopg2

# Iniciar servidor de desarrollo Django
echo "Iniciando servidor de desarrollo de Django..."
cd ../persona
python manage.py runserver 8001 > django.log 2>&1 &

# Iniciar servidor de desarrollo Vue.js
echo "Iniciando servidor de desarrollo de Vue.js..."
cd ../tutorial-vue
npm run dev > vue.log 2>&1 &

# Finalización
echo "Todo configurado. El proyecto está corriendo en local."
echo "Accede a Django en http://127.0.0.1:8000 y a Vue.js en http://localhost:8080"
