<template>
  <section
      class="flex self-center
       justify-center items-center flex-1 text-darkBlue relative"
  >
    <div
        :class="{
          rotationCard: !faceCardVisible,
        }"
        class="card w-72 h-[390px] bg-headerFooter rounded-lg sm:w-80 md:w-96 sm:h-[450px]"
    >

      <div
          class="card-front text-white px-5 py-6"
      >
        <h1 class="text-center font-bold">Connexion</h1>
        <form @submit.prevent="signInWithCredentials" class="m-auto h-full">
          <div class="flex flex-col gap-10 mt-10">
            <input
                type="email"
                name="email"
                placeholder="Email"
                aria-label="email"
                class="custom_input"
                required
                v-model="signInEmail"
            />
            <input
                type="password"
                name="password"
                placeholder="Mot de passe"
                aria-label="Mot de passe"
                class="custom_input"
                required
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
          class="card-back text-white px-5 py-6 flex flex-col gap-2 sm:gap-4"
      >
        <h1 class="text-center font-bold">Inscription</h1>
        <form @submit.prevent="signUpWithFormData" class="flex flex-col gap-2 sm:gap-4" ref="signUpForm">
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
          <input
              type="password"
              name="password"
              placeholder="Confirmation mot de passe"
              aria-label="Confirmation mot de passe"
              class="custom_input"
              v-model="confirmationSignUpPassword"
              required
          />
          <div class="text-center mt-2">
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
    <div v-if="showModal"
         class="absolute top-1/2 left-1/2 -translate-y-1/2 -translate-x-1/2 bg-card p-10 flex items-center justify-center flex-col gap-y-5 rounded-2xl">
      <h1 class="text-xl text-nowrap">Entrez le code que vous avez reçu par E-mail</h1>
      <p class="text-xs">N'oublier pas d'aller voir dans vos spams</p>
      <input type="text" v-model="inputCode">
      <button class="custom_btn" @click="verifyCode">Vérifier</button>
      <p v-if="showErrorMessage" class="text-sm text text-red-600">Le code de vérification ne correspond pas !</p>
    </div>
  </section>
</template>
<script setup lang="ts">
definePageMeta({
  middleware: 'auth',
  auth: {
    unauthenticatedOnly: true,
    navigateAuthenticatedTo: '/allPosts',
  },
})
const error = useError();
const {signIn, status, token} = useAuth();
const showModal = ref(false)
const signUpEmail = ref("");
const signUpPassword = ref("");
const firstName = ref("");
const lastName = ref("");
const signInEmail = ref("");
const signInPassword = ref("");
const confirmationSignUpPassword = ref("")
const pseudo = ref("");
const inputCode = ref("")
const signUpForm = ref(null);
const signUpErrorMessage = ref("");
const signInErrorMessage = ref("");
const passwordErrorInfo = ref(false);
const textBannerMessage = ref("");
const dataForm = ref()
const code = ref()
const showErrorMessage = ref(false)
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
};
const validatePseudo = (pseudo: string) => {
  const lowercaseCount = (pseudo.match(/[a-z]/g) || []).length;
  return (pseudo.length >= 5 && !/\s/.test(pseudo) && lowercaseCount >= 3);
};

async function signUpWithFormData() {
  if (!validateEmail(signUpEmail.value)) {
    signUpErrorMessage.value = "L'email est invalide";
    throw new Error("L'email est invalide");

  } else if (!validatePassword(signUpPassword.value)) {
    passwordErrorInfo.value = true;
    textBannerMessage.value = `
        <p>"Le mot de passe est invalide."</p>
        <p>Votre mot de passe doit contenir :</p>
        <ul class="list-disc list-inside">
          <li>Minimum 8 caractères</li>
          <li>Au moins une majuscule</li>
          <li>Au moins une minuscule</li>
          <li>Au moins un chiffre</li>
          <li>Au moins un caractère spécial</li>
        </ul>`;
    setTimeout(() => {
      passwordErrorInfo.value = false;
      textBannerMessage.value = '';
    }, 6000)
    throw new Error("Le mot de passe est invalide");
  } else if (signUpPassword.value !== confirmationSignUpPassword.value) {
    signUpErrorMessage.value = 'Les mots de passe ne correspondent pas !'
    throw new Error('Les mots de passe ne correspondent pas !')
  } else if (!validatePseudo(pseudo.value)) {
    passwordErrorInfo.value = true;
    textBannerMessage.value = `
        <p>Le pseudo est invalide.</p>
        <p>Le pseudo doit contenir :</p>
        <ul class="list-disc list-inside">
          <li>Minimum 5 caractères</li>
          <li>Ne doit pas contenir d'espaces</li>
          <li>Au moins trois minuscules</li>
        </ul>`;
    setTimeout(() => {
      passwordErrorInfo.value = true;
    }, 6000)
    throw new Error("Le pseudo est invalide")
  }
  code.value = String(Math.floor(Math.random() * 9000 + 1000));
  if (signUpForm.value) dataForm.value = new FormData(signUpForm.value);
  dataForm.value.set('code', code.value)
  const response = await fetch("api/auth/register", {
    method: "POST",
    body: dataForm.value
  });
  if (!response.ok) {
    if (response.statusText === "emailExist") {
      signUpErrorMessage.value = `Cette adresse mail est déjà utilisée. <br> Connectez-vous !`;
    } else if (response.statusText === "pseudoExist") {
      signUpErrorMessage.value = `Ce pseudo est déjà utilisé, <br> chosissez-en un autre !`;
    }
  } else {
    showModal.value = true;
  }
}

async function verifyCode() {
  if (inputCode.value === code.value) {
    try {
      const profil = await fetch("api/auth/profil", {
        method: "POST",
        body: dataForm.value
      })
      await navigateTo("/confirmSignUp");
    } catch (error) {
      return error;
    }
  } else showErrorMessage.value = true;
}

async function signInWithCredentials() {
  const credentials = {
    email: signInEmail.value,
    password: signInPassword.value,
  };
  try {
    await signIn(credentials, {callbackUrl: "/confirmConnexion"});
  } catch (err) {
    signInErrorMessage.value = "E-mail ou mot de passs incorrect";
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
  transition: all 0.5s ease;
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

.bg-card {
  background-image: linear-gradient(45deg, #93a5cf 0%, #e4efe9 100%);
}
</style>
