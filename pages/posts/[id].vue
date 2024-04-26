<template>
  <main class="flex flex-col min-h-svh text-darkBlue">
    <the-header></the-header>
    <section v-if="data">
      <pre>{{ data }}</pre>
    </section>
    <the-footer></the-footer>
  </main>
</template>

<script setup lang="ts">

const route = useRoute()
const data = ref()

onBeforeMount(async () => {
  try {
    const response = await fetch(`/api/posts/${route.params.id}`)
    data.value = await response.json()
  } catch (error) {
    console.error("Erreur lors de la récupération des données")
  }
})
</script>


<style scoped>

</style>