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

# Activar el entorno virtual en el entorno actual
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
    echo "from django.contrib.auth.models import User; User.objects.create_superuser('alumnodb', 'admin@example.com', 'alumnodb')" | python manage.py shell
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
pip install django-cors-headers

# Agregar CORS_ORIGIN_WHITELIST al archivo settings.py si no está presente
echo "CORS_ORIGIN_WHITELIST = ['${VUE_URL}']" >> ../persona/persona/settings.py

# Instalando dependencias de la base de datos (Neon)
echo "Instalando dependencias de la base de datos..."
pip install psycopg2

#servidores
echo ""
echo "Abre una terminal dandole al mas arriba a la izquierda de la ventana de la terminal y escribe lo siguiente:"
echo "source env/bin/activate && cd persona && python manage.py runserver 8001"

echo ""
echo "Abre otra terminal de la misma manera y escribe lo siguiente:"
echo "source env/bin/activate && cd tutorial-vue && npm run dev"
# Finalización
echo ""
echo "Todo configurado. El proyecto está corriendo en local."
echo "Revisa las terminales abiertas para ver en qué puertos están corriendo Django y Vue.js."
echo ""
echo "Aparte, puedes acceder a estos links de render con su despliegue en esta plataforma: "
echo "https://p2-psi-yraj.onrender.com/             https://p2-psi-server.onrender.com"
echo "(la parte de poner la api en render no hemos conseguido sacarla y render ha dado errores de última hora y no nos da tiempo a encontrar el error ahora mismo)"
