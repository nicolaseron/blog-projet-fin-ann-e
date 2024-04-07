<template>
  <main class="min-h-svh flex flex-col">
    <TheHeader></TheHeader>
    <section
        class="bg-background flex justify-center items-center flex-1 text-darkBlue relative"
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
                <p v-if="signInErrorMessage" class="text-red-500 mt-5" v-html="signInErrorMessage"></p>
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
            <p v-if="signUpErrorMessage" class="text-red-500" v-html="signUpErrorMessage"></p>
            <button
                class="rotate_btn hover:underline absolute bottom-3 text-nowrap left-1/2 -translate-x-1/2"
                @click="toggleFaceCard"
            >
              Déjà inscrit ? Me connecter !
            </button>
          </div>
        </div>
      </div>
      <div :class="{displayErrorMessage : passwordErrorInfo}"
           class="bg-red-500 absolute bottom-10 right-10 opacity-0 transition-opacity text-white p-5 rounded-3xl"
           v-html="textBannerMessage">
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
const signUpForm = ref(null)
const signUpErrorMessage = ref("")
const signInErrorMessage = ref("")
const passwordErrorInfo = ref(false)
const textBannerMessage = ref("")
const validateEmail = (email: string) => {
  return String(email)
      .toLowerCase()
      .match(
          /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
      );
};
const validatePassword = (pw: string) => {
  return /[A-Z]/.test(pw) &&
      /[a-z]/.test(pw) &&
      /[0-9]/.test(pw) &&
      /[^A-Za-z0-9]/.test(pw) &&
      pw.length > 8;
}

const validatePseudo = (pseudo: string) => {
  const lowercaseCount = (pseudo.match(/[a-z]/g) || []).length;
  return (pseudo.length >= 5 && !/\s/.test(pseudo) && lowercaseCount >= 3);
}

async function signUpWithFormData() {
  if (!validateEmail(signUpEmail.value)) {
    signUpErrorMessage.value = "L'email est invalide"
    throw new Error("L'email est invalide")

  } else if (!validatePassword(signUpPassword.value)) {
    passwordErrorInfo.value = true
    textBannerMessage.value = `
        <p>"Le mot de passe est invalide."</p>
        <p>Votre mot de passe doit contenir :</p>
        <ul class="list-disc list-inside">
          <li>Minimum 8 caractères</li>
          <li>Au moins une majuscule</li>
          <li>Au moins une minuscule</li>
          <li>Au moins un chiffre</li>
          <li>Au moins un caractère spécial</li>
        </ul>`
    setTimeout(() => {
      passwordErrorInfo.value = false
    }, 6000)
    throw new Error("Le mot de passe est invalide")
  } else if (!validatePseudo(pseudo.value)) {
    passwordErrorInfo.value = true
    textBannerMessage.value = `
        <p>Le pseudo est invalide.</p>
        <p>Le pseudo doit contenir :</p>
        <ul class="list-disc list-inside">
          <li>Minimum 5 caractères</li>
          <li>Ne doit pas contenir d'espaces</li>
          <li>Au moins trois minuscule</li>
        </ul>`
    setTimeout(() => {
      passwordErrorInfo.value = true
    }, 6000)
    throw new Error("Le pseudo est invalide")
  }
  const dataForm = new FormData(signUpForm.value);
  const response = await fetch("api/auth/register", {
    method: "POST",
    body: dataForm
  })
  if (!response.ok) {
    if (response.statusText === "emailExist") {
      signUpErrorMessage.value = `Cette adresse mail est déjà utilisée. <br> Connectez-vous !`
    } else if (response.statusText === "pseudoExist") {
      signUpErrorMessage.value = `Ce pseudo est déjà utilisé, <br> chosissez-en un autre !`
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
    signInErrorMessage.value = "E-mail ou mot de passs incorrect"
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

.displayErrorMessage {
  opacity: 1;
  transition: opacity 2s ease;
}
</style>
