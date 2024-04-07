<template>
  <main class="min-h-svh flex flex-col">
    <TheHeader></TheHeader>
    <section
        class="bg-background flex justify-center items-center flex-1 text-darkBlue"
    >
      <div
          :class="{
          rotationCard: !faceCardVisible,
        }"
          class="card w-72 h-[390px] sm:w-80 md:w-96 sm:h-[450px]"
      >

        <div
            class="card-front bg-headerFooter text-white rounded-lg px-5 py-6"
        >
          <h1 class="text-center font-bold">Connexion</h1>
          <form @submit.prevent="signInWithCredentials" class="m-auto h-full">
            <div class="flex flex-col  gap-10 mt-10">
              <input
                  type="email"
                  name="email"
                  placeholder="Email"
                  aria-label="email"
                  class="custom_input"
                  v-model="signInEmail"
              />
              <input
                  type="password"
                  name="password"
                  placeholder="Mot de passe"
                  aria-label="Mot de passe"
                  class="custom_input"
                  v-model="signInPassword"
              />
<!--              <a href="#" class="mb-5 hover:underline">Mot de passe oublié ?</a>-->
              <div class="text-center">
                <button type="submit" class="custom_btn">Me connecter</button>
                <p v-if="signUpErrorMessage" class="text-red-500 mt-5" v-html="signUpErrorMessage"></p>
              </div>
            </div>
          </form>
          <div class="text-center">
            <button
                @click="toggleFaceCard"
                class="rotate_btn hover:underline absolute bottom-3 text-nowrap left-1/2 -translate-x-1/2"
            >
              Pas encore de compte ? S'inscrire !
            </button>
          </div>
        </div>
        <div
            class="card-back bg-headerFooter text-white rounded-lg px-5 py-6 flex flex-col gap-5"
        >
          <h1 class="text-center font-bold">Inscription</h1>
          <form @submit.prevent="signUpWithFormData" class="flex flex-col gap-5" ref="signUpForm">
            <input
                type="text"
                name="lastName"
                id="lastName"
                placeholder="Nom"
                aria-label="nom"
                class="custom_input"
                v-model="lastName"
                required
            />
            <input
                type="text"
                name="firstname"
                id="firstname"
                placeholder="Prénom"
                aria-label="prénom"
                class="custom_input"
                v-model="firstName"
                required
            />
            <input
                type="text"
                name="pseudo"
                id="pseudo"
                placeholder="Pseudo"
                aria-label="pseudo"
                class="custom_input"
                v-model="pseudo"
                required
            />
            <input
                type="email"
                name="email"
                placeholder="Email"
                aria-label="email"
                class="custom_input"
                v-model="signUpEmail"
                required
            />
            <input
                type="password"
                name="password"
                placeholder="Mot de passe"
                aria-label="Mot de passe"
                class="custom_input"
                v-model="signUpPassword"
                required
            />
            <div class="text-center">
              <button type="submit" class="custom_btn">M'inscrire !</button>
            </div>
          </form>
          <div class="text-center">
            <p v-if="errorMessage" class="text-red-500" v-html="errorMessage"></p>
            <button
                class="rotate_btn hover:underline absolute bottom-3 text-nowrap left-1/2 -translate-x-1/2"
                @click="toggleFaceCard"
            >
              Déjà inscrit ? Me connecter !
            </button>
          </div>
        </div>
      </div>
    </section>
    <the-footer></the-footer>
  </main>
</template>
<script setup lang="ts">
definePageMeta({
  middleware: 'auth',
  auth: {
    unauthenticatedOnly: true,
    navigateAuthenticatedTo: '/allPosts',
  },
})
const error = useError()
const {signIn, status, token} = useAuth()

console.log(status.value)

const signUpEmail = ref("")
const signUpPassword = ref("")
const firstName = ref("")
const lastName = ref("")
const signInEmail = ref("")
const signInPassword = ref("")
const pseudo = ref("")
const errorMessage = ref("")
const signUpForm = ref(null)
const signUpErrorMessage = ref("")

async function signUpWithFormData() {
  const dataForm = new FormData(signUpForm.value);
  const response = await fetch("api/auth/register", {
    method: "POST",
    body: dataForm
  })
  if (!response.ok) {
    if (response.statusText === "emailExist")
      errorMessage.value = `Cette adresse mail est déjà utilisée. <br> Connectez-vous !`
    else if (response.statusText === "pseudoExist") {
      errorMessage.value = `Ce pseudo est déjà utilisé, <br> chosissez-en un autre !`
    }
  } else {
    await navigateTo("/confirmSignUp")
  }
}

async function signInWithCredentials() {
  const credentials = {
    email: signInEmail.value,
    password: signInPassword.value,
  }
  try {
    await signIn(credentials, {callbackUrl: "/confirmConnexion"})
  } catch (err) {
    signUpErrorMessage.value = "E-mail ou mot de passs incorrect"
  }
}

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
