<template>
  <main class="min-h-svh flex flex-col">
    <the-header></the-header>
    <div class="flex-1 flex justify-center items-center">
      <div class="w-[800px] p-10 bg-blue-50 border flex flex-col justify-center gap-5 text-center">
        <h1 class="text-4xl">Félications vous êtes bien inscrit ! &#x1F389;</h1>
        <p>Il ne reste plus qu'à vous connecter et vous pourrez utiliser toutes les fonctionnalitées du site.</p>
        <NuxtLink to="connexion" class="custom_btn w-fit m-auto">Me connecter</NuxtLink>
      </div>
    </div>
    <the-footer></the-footer>
  </main>
</template>
<script setup lang="ts">
definePageMeta({
  middleware: 'auth',
  auth: {
    unauthenticatedOnly: true,
    navigateAuthenticatedTo: '/confirmConnexion',
  },
})
</script>