<template>
    <div class="flex-1 flex justify-center items-center">
      <div class="max-w-[800px] m-10 p-5 sm:p-10 border flex flex-col justify-center gap-5 text-center bg-card ">
        <h1 class="text-4xl">Félications vous êtes bien inscrit&nbsp;! &#x1F389;</h1>
        <p>Il ne reste plus qu'à vous connecter et vous pourrez utiliser toutes les fonctionnalitées du site.</p>
        <NuxtLink to="connexion" class="custom_btn w-fit m-auto">Me connecter</NuxtLink>
      </div>
    </div>
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

<style scoped>
.bg-card {
  background-image: linear-gradient(45deg, #93a5cf 0%, #e4efe9 100%);
}
</style>