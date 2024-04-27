<template>
  <nav
      class="bg-headerFooter py-3 px-2 text-white flex flex-col items-center sm:px-10 sm:flex-row sm:justify-between"
  >
    <div class="flex items-center gap-5 flex-auto">
      <img
          src="/logo/coffee-cup-with-heart-svgrepo-com.svg"
          class="w-8"
          alt=""
      />
      <nuxtLink
          to="/"
          title="Retouner sur la page d'accueil"
          class="text-xl font-bold"
      >Coffee Time !
      </nuxtLink
      >
    </div>
    <div class="flex gap-x-5 my-2 flex-auto justify-between items-center">
      <NuxtLink to="/allPosts" class="custom_btn"> Les postes</NuxtLink>
      <div v-if="isLoggedIn" class="flex gap-x-5">
        <nuxt-link to="/profil" class="custom_btn">{{data.response.firstName}} <i class="icon icon-user"></i></nuxt-link>
        <button @click="handleSignOut" class="custom_btn">Déconnexion</button>
      </div>
      <NuxtLink v-else to="/connexion" class="custom_btn">
        Connexion / Inscription
      </NuxtLink>
    </div>
  </nav>
</template>
<script setup lang="ts">

const {signOut, status, data, getSession} = useAuth();
const isLoggedIn = computed(() => status.value === "authenticated")

async function handleSignOut() {
  await signOut({callbackUrl: "/"});
  await getSession()
}
</script>