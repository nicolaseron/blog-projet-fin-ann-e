<template>
  <main class="min-h-svh flex flex-col">
    <the-header></the-header>
    <div class="flex-1 flex justify-center items-center">
      <div class="w-[800px] p-10 bg-blue-50 border flex flex-col justify-center gap-5 text-center">
        <h1 class="text-4xl">Félications vous êtes connecté ! &#x1F389;</h1>
        <h2 class="text-2xl">Bienvenu {{ profil.firstName }} &#x1F44B;</h2>
        <p>Vous pouvez maintenant profiter de toute les fonctionnalités du site ! C'est à dire ajouter vos propres
          postes, commenter ceux des autres , etc...</p>
      </div>
    </div>
    <the-footer></the-footer>
  </main>
</template>
<script setup lang="ts">
definePageMeta({middleware: 'auth'})
const {data} = useAuth();
const profil = data.value.response;
// const profil= ref(null)
// if (data.value) {
//   profil.value = data.value.response
// }
</script>