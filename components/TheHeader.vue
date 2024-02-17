<template>
  <nav
    class="bg-blue500 border-blue300 py-3 px-2 border-b text-white flex flex-col items-center sm:px-10 sm:flex-row sm:justify-between"
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
        class="text-xl font-bold hover:text-blue200"
        >Coffee Time !</nuxtLink
      >
    </div>
    <div class="flex gap-x-5 my-2 flex-auto justify-between">
      <NuxtLink to="/allPosts" class="custom_btn"> Les postes </NuxtLink>
      <NuxtLink to="/connexion" class="custom_btn">
        Connexion / Inscription
      </NuxtLink>
    </div>
  </nav>
</template>
<script></script>
