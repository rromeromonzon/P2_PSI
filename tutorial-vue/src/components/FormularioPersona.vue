<!-- FormularioPersona.vue -->
<template>
  <!-- Contenedor principal del componente -->
  <div id="formulario-persona" @add-persona="agregarPersona">
    <!-- Formulario con campos para ingresar informacion de una persona -->
    <form @submit.prevent="enviarFormulario">
      <div class="container">
        <!-- Primera fila con campos de nombre, apellido y email -->
        <div class="row">
          <div class="col-md-4">
            <div class="form-group">
              <!-- Etiqueta y campo de entrada para el nombre -->
              <label>Nombre</label>
              <input
                ref="nombre"
                v-model="persona.nombre"
                type="text"
                class="form-control"
                data-cy="name"
                :class="{ 'is-invalid': procesando && nombreInvalido }"
                @focus="resetEstado"
                @keypress="resetEstado"
              />
            </div>
          </div>
          <div class="col-md-4">
            <div class="form-group">
              <!-- Etiqueta y campo de entrada para el apellido -->
              <label>Apellido</label>
              <input
                v-model="persona.apellido"
                type="text"
                class="form-control"
                data-cy="surname"
                :class="{ 'is-invalid': procesando && apellidoInvalido }"
                @focus="resetEstado"
              />
            </div>
          </div>
          <div class="col-md-4">
            <div class="form-group">
              <!-- Etiqueta y campo de entrada para el correo electronico -->
              <label>Email</label>
              <input
                v-model="persona.email"
                type="email"
                class="form-control"
                data-cy="email"
                :class="{ 'is-invalid': procesando && emailInvalido }"
                @focus="resetEstado"
              />
            </div>
          </div>
        </div>
        <!-- Segunda fila con un boton para agregar persona -->
        <div class="row">
          <div class="col-md-4">
            <div class="form-group">
              <!-- Boton para añadir persona -->
              <button class="btn btn-primary" data-cy="add-button">
                Añadir persona
              </button>
            </div>
          </div>
        </div>
      </div>
      <br />
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div
              v-if="error && procesando"
              class="alert alert-danger"
              role="alert"
            >
              Debes rellenar todos los campos correctamente!
            </div>
            <div v-if="correcto" class="alert alert-success" role="alert">
              La persona ha sido agregada correctamente!
            </div>
          </div>
        </div>
      </div>
    </form>
  </div>
</template>

<script setup>
// Importacion de la funcion "ref" de Vue 3
import { ref, computed } from "vue";

// definicion del componente
defineOptions({
  // nombre del componente
  name: "FormularioPersona",
});

// Declaracion de una variable reactiva "persona" con propiedades nombre, apellido y email
const persona = ref({
  nombre: "",
  apellido: "",
  email: "",
});

const nombreInvalido = computed(() => persona.value.nombre.length < 1);
const apellidoInvalido = computed(() => persona.value.apellido.length < 1);
const emailInvalido = computed(() => {
  const regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
  return !regex.test(persona.value.email);
});

const procesando = ref(false);
const correcto = ref(false);
const error = ref(false);

const emit = defineEmits(["add-persona"]);
const nombre = ref(null);

const enviarFormulario = () => {
  procesando.value = true;
  resetEstado();
  console.log("Works!");
  // Validamos que los campos no estén vacíos
  if (nombreInvalido.value || apellidoInvalido.value || emailInvalido.value) {
    error.value = true;
    return;
  }

  emit("add-persona", { ...persona.value });
  nombre.value.focus();
  console.log("Persona enviada (FormPers):", { ...persona.value }); // <-- Verifica qué datos se están enviando

  persona.value = { nombre: "", apellido: "", email: "" };

  error.value = false;
  correcto.value = true;
  procesando.value = false;
};

const resetEstado = () => {
  correcto.value = false;
  error.value = false;
};
</script>

<style scoped>
/* Estilos especificos del componente con el modificador "scoped" */
form {
  margin-bottom: 2rem;
}
</style>
