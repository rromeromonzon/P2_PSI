<!-- src/components/TablaPersonas.vue -->
<template>
  <!-- Contenedor principal del componente -->
  <div id="tabla-personas">
    <!-- Tabla para mostrar informacion de personas -->
    <table class="table">
      <!-- Encabezado de la tabla -->
      <thead>
        <tr>
          <!-- Columnas del encabezado -->
          <th>Nombre</th>
          <th>Apellido</th>
          <th>Email</th>
          <th>Acciones</th>
        </tr>
      </thead>
      <!-- Cuerpo de la tabla -->
      <tbody>
        <!-- Iteracion sobre el array de personas utilizando v-for -->
        <tr v-for="persona in personas" :key="persona.id">
          <td v-if="editando === persona.id">
            <input
              id="persona.nombre"
              v-model="persona.nombre"
              type="text"
              class="form-control"
              data-cy="persona-nombre"
            />
          </td>
          <td v-else>
            {{ persona.nombre }}
          </td>
          <td v-if="editando === persona.id">
            <input
              v-model="persona.apellido"
              type="text"
              class="form-control"
            />
          </td>
          <td v-else>
            {{ persona.apellido }}
          </td>
          <td v-if="editando === persona.id">
            <input v-model="persona.email" type="email" class="form-control" />
          </td>
          <td v-else>
            {{ persona.email }}
          </td>
          <td>
            <template v-if="editando === persona.id">
              <button
                class="btn btn-success"
                data-cy="save-button"
                @click="guardarPersona(persona)"
              >
                &#x1F5AB; Guardar
              </button>
              <button
                class="btn btn-secondary ml-2"
                data-cy="cancel-button"
                @click="cancelarEdicion(persona)"
              >
                &#x1F5D9; Cancelar
              </button>
            </template>
            <template v-else>
              <button
                class="btn btn-info"
                data-cy="edit-button"
                @click="editarPersona(persona)"
              >
                &#x1F58A; Editar
              </button>
              <button
                class="btn btn-danger ml-2"
                data-cy="delete-button"
                @click="$emit('delete-persona', persona.id)"
              >
                &#x1F5D1; Eliminar
              </button>
            </template>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script setup>
import { defineProps, ref, defineEmits } from "vue";

// Definicion del componente Vue
defineOptions({
  // Nombre del componente
  name: "TablaPersonas",
});

// declaramos y damos valor por defecto para la propiedad personas
const { personas } = defineProps({
  personas: { type: Array, default: () => [] },
});

const emit = defineEmits(["delete-persona", "actualizar-persona"]);

const editando = ref(null);
const personaEditada = ref(null);

const editarPersona = (persona) => {
  personaEditada.value = { ...persona };
  editando.value = persona.id;
};

const guardarPersona = (persona) => {
  if (
    !persona.nombre.length ||
    !persona.apellido.length ||
    !persona.email.length
  ) {
    return;
  }
  emit("actualizar-persona", persona.id, persona);
  editando.value = null;
};

const cancelarEdicion = () => {
  emit("actualizar-persona", personaEditada.value.id, personaEditada.value);
  editando.value = null;
  personaEditada.value = null;
};
</script>

<style scoped>
/* Estilos especificos del componente con el modificador "scoped" */
</style>
