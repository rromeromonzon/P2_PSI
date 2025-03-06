<template>
  <div id="app" class="container">
    <div class="row">
      <div class="col-md-12">
        <h1>Personas</h1>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <formulario-persona @add-persona="agregarPersona" />
        <!-- NUEVO -->
        <!-- Inclusion del componente "TablaPersonas" -->
        <div v-if="!personas.length" class="alert alert-info" role="alert">
          No se han encontrado personas
        </div>
        <div v-else>
          <table class="table"></table>
        </div>
        <tabla-personas
          :personas="personas"
          @delete-persona="eliminarPersona"
          @actualizar-persona="actualizarPersona"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import TablaPersonas from "@/components/TablaPersonas.vue";
import FormularioPersona from "@/components/FormularioPersona.vue";

// Definicion del componente Vue
defineOptions({
  name: "App",
});

const personas = ref([]);

const agregarPersona = (persona) => {
  console.log("Persona recibida", persona);
  let id = 0;
  if (personas.value.length > 0) {
    id = personas.value[personas.value.length - 1].id + 1;
  }
  // actualizamos el valor del array creando un nuevo array con los valores existentes y agregando la nueva persona
  personas.value = [...personas.value, { ...persona, id }];
};

const eliminarPersona = (id) => {
  try {
    personas.value = personas.value.filter((u) => u.id !== id);
  } catch (error) {
    console.error(error);
  }
};

const actualizarPersona = (id, personaActualizada) => {
  try {
    const persona = personas.value.find((persona) => persona.id === id);
    console.log("Persona antes de actualizar:", persona); // Imprime la persona antes de actualizarla
    console.log("Persona actualizada:", personaActualizada); // Imprime la persona actualizada
    personas.value = personas.value.map((persona) =>
      persona.id === id ? { ...persona, ...personaActualizada } : persona
    );
    console.log("Persona tras actualizar:", personas.value); // 🔍 Verifica si el array cambia
  } catch (error) {
    console.error("Error al actualizar persona:", error);
  }
};
</script>

<style>
/* Estilos globales para todos los elementos button en la aplicacion */
button {
  background: #009435;
  border: 1px solid #009435;
}
</style>
