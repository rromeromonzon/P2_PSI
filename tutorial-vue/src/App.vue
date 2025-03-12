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
        <tabla-personas :personas="personas" @delete-persona="eliminarPersona"
          @actualizar-persona="actualizarPersona" />
      </div>
    </div>
  </div>
  <div>
    <p>Count is {{ store.count }}</p>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import TablaPersonas from "@/components/TablaPersonas.vue";
import FormularioPersona from "@/components/FormularioPersona.vue";
import { useCounterStore } from "./stores/counter";

// Definicion del componente Vue
defineOptions({
  name: "App",
});

const personas = ref([]);
const store = useCounterStore();

onMounted(() => {
  listadoPersonas();
});

const listadoPersonas = async () => {
  // Metodo para obtener un listado de personas
  try {
    const response = await fetch("http://localhost:8001/api/v1/personas/");
    personas.value = await response.json();
  } catch (error) {
    console.error(error);
  }
};

const agregarPersona = async (persona) => {
  try {
    const response = await fetch("http://localhost:8001/api/v1/personas/", {
      method: "POST",
      body: JSON.stringify(persona),
      headers: { "Content-type": "application/json; charset=UTF-8" },
    });
    const personaCreada = await response.json();
    personas.value = [...personas.value, personaCreada];
    store.increment();
  } catch (error) {
    console.error(error);
  }
};

const eliminarPersona = async (persona_id) => {
  // Metodo para eliminar una persona
  try {
    await fetch("http://localhost:8001/api/v1/personas/" + persona_id + "/", {
      method: "DELETE",
    });
    personas.value = personas.value.filter((u) => u.id !== persona_id);
    store.decrement();
  } catch (error) {
    console.error(error);
  }
};
const actualizarPersona = async (id, personaActualizada) => {
  // Metodo para actualizar una persona
  try {
    const response = await fetch(
      "http://localhost:8001/api/v1/personas/" + personaActualizada.id + "/",
      {
        method: "PUT",
        body: JSON.stringify(personaActualizada),
        headers: { "Content-type": "application/json; charset=UTF-8" },
      }
    );
    const personaActualizadaJS = await response.json();
    console.log(personaActualizadaJS); // Verifica el ID aquí
    personas.value = personas.value.map((u) =>
      u.id === personaActualizada.id ? personaActualizadaJS : u
    );
  } catch (error) {
    console.error(error);
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
