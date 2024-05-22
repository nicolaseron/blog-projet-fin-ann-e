<template>
    <section class="flex-1 flex justify-center items-center">
      <div class="max-w-[800px] m-10 p-5 sm:p-10 border flex flex-col justify-center gap-5 text-center bg-card ">
        <h1 class="text-4xl">Félications vous êtes connecté ! &#x1F389;</h1>
        <h2 class="text-2xl">Bienvenue {{ profil.firstName }} &#x1F44B;</h2>
        <p>Vous pouvez maintenant profiter de toute les fonctionnalités du site ! C'est à dire ajouter vos propres
          postes, commenter ceux des autres , etc...</p>
      </div>
    </section>
</template>
<script setup lang="ts">
definePageMeta({middleware: 'auth'})
const {data} = useAuth();
const profil = data.value.response;
</script>

<style scoped>
.bg-card {
  background-image: linear-gradient(45deg, #93a5cf 0%, #e4efe9 100%);
}
</style>