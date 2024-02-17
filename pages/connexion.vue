<template>
  <main class="min-h-svh flex flex-col">
    <TheHeader></TheHeader>
    <section class="bg-black flex justify-center items-center flex-1">
      <div
        :class="{
          rotationCard: !faceCardVisible,
        }"
        class="card w-72 h-[390px]"
      >
        <div
          class="card-front bg-blue400 text-blue100 rounded-lg px-5 py-6 flex flex-col gap-5"
        >
          <h1 class="text-center font-bold">Inscription</h1>
          <form action="#" class="flex flex-col gap-5">
            <input
              type="text"
              name="lastName"
              id="lastName"
              placeholder="Nom"
              aria-label="nom"
              class="custom_input"
            />
            <input
              type="text"
              name="firstname"
              id="firstname"
              placeholder="Prénom"
              aria-label="prénom"
              class="custom_input"
            />
            <div class="flex justify-between">
              <input type="radio" name="gender" id="men" value="men" checked />
              <label for="men">Homme</label>
              <input type="radio" name="gender" id="women" value="women" />
              <label for="women">Femme</label>
              <input type="radio" name="gender" id="other" value="other" />
              <label for="other">Autre</label>
            </div>
            <input
              type="email"
              name="email"
              placeholder="Email"
              aria-label="email"
              class="custom_input"
            />
            <input
              type="password"
              name="password"
              placeholder="Mot de passe"
              aria-label="Mot de passe"
              class="custom_input"
            />
            <div class="text-center">
              <button type="submit" class="custom_btn">M'inscrire !</button>
            </div>
          </form>
          <div class="text-center">
            <button
              class="rotate_btn hover:underline absolute bottom-3 text-nowrap left-1/2 -translate-x-1/2"
              @click="toggleFaceCard"
            >
              Déjà inscrit ? Me connecter !
            </button>
          </div>
        </div>
        <div
          class="card-back bg-blue400 text-blue100 rounded-lg px-5 py-6 flex flex-col gap-5 relative"
        >
          <h1 class="text-center font-bold">Connexion</h1>
          <div class="my-auto flex flex-col gap-5">
            <input
              type="email"
              name="email"
              placeholder="Email"
              aria-label="email"
              class="custom_input"
            />
            <input
              type="password"
              name="password"
              placeholder="Mot de passe"
              aria-label="Mot de passe"
              class="custom_input"
            />
            <a href="#" class="mb-5 hover:underline">Mot de passe oublié ?</a>
            <div class="text-center">
              <button class="custom_btn">Me connecter</button>
            </div>
          </div>
          <div class="text-center">
            <button
              @click="toggleFaceCard"
              class="rotate_btn hover:underline absolute bottom-3 text-nowrap left-1/2 -translate-x-1/2"
            >
              Pas encore de compte ? S'inscrire !
            </button>
          </div>
        </div>
      </div>
    </section>
    <the-footer></the-footer>
  </main>
</template>
<script setup lang="ts">
const faceCardVisible = ref(true);
function toggleFaceCard() {
  faceCardVisible.value = !faceCardVisible.value;
}
</script>
<style>
.rotationCard {
  transform: rotateY(180deg);
}

.card {
  transition: all 0.3s ease;
  transform-style: preserve-3d;
}
.card-front {
  @apply absolute h-full w-full;
  backface-visibility: hidden;
}
.card-back {
  @apply absolute h-full w-full;
  backface-visibility: hidden;
  transform: rotateY(-180deg);
}
</style>
