<template>
  <main class="flex flex-col min-h-svh text-darkBlue">
    <the-header></the-header>
    <section class="flex-1 flex justify-center items-center">
      <div class="w-[800px] p-10 bg-blue-50 border flex flex-col justify-center gap-5 text-center">
        <h1 class="text-4xl">Bienvenu sur votre profil ! &#x1F64B;</h1>
        <p>Nom : {{ data.response.lastName }}</p>
        <p>Prénom : {{ data.response.firstName }}</p>
        <p>Email : {{ data.response.email }}</p>
        <p>Pseudo : {{ data.response.pseudo }}</p>
      </div>
    </section>
    <the-footer></the-footer>
  </main>
</template>
<script setup lang="ts">
const {data} = useAuth()
</script>

<style scoped>

</style>