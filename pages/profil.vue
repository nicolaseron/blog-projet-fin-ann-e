<template>
  <section class="flex-1 flex justify-center items-center">
    <div class="max-w-[1000px] m-10 p-5 sm:p-10 flex flex-col justify-center gap-5 text-center rounded-lg bg-card">
      <h1 class="text-4xl">Vos informations de profil &#x1F64B;</h1>
      <p>Nom : {{ data.response.lastName }}</p>
      <p>Prénom : {{ data.response.firstName }}</p>
      <p>Email : {{ data.response.email }}</p>
      <p>Pseudo : {{ data.response.pseudo }}</p>
      <p>Admin : {{ data.response.admin ? 'Oui' : 'Non' }}</p>
    </div>
  </section>
</template>
<script setup lang="ts">
definePageMeta({middleware: 'auth'});
const {data} = useAuth()
</script>

<style scoped>
.bg-card {
  background-image: linear-gradient(45deg, #93a5cf 0%, #e4efe9 100%);
}
</style>
