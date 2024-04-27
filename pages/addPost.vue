<template>
  <section class="flex-1 flex p-10 flex-col lg:flex-row">
    <form @submit.prevent="sendPost" class="flex-1" ref="myForm">
      <div class="flex flex-col gap-y-5">
        <div class="flex flex-col gap-y-3">
          <label for="image"
          >Choisissez une image
            <span class="text-xs italic">(format accepté : '.png','.jpg','.jpeg','.webp')</span>
            :
          </label>
          <input
              type="file"
              name="image"
              id="image"
              accept=".png,.jpg,.jpeg,.webp"
              @change="addPreviewImg"
              required
              ref="img"
          />
        </div>
        <div>
          <label for="title" class="mr-2">Titre du poste : </label>
          <input
              v-model="title"
              type="text"
              name="title"
              id="title"
              required
              class="custom_input"
          />
        </div>
        <div class="flex gap-x-3">
          <label for="content">Contenu du poste&nbsp;:</label>
          <textarea
              class="bg-transparent border border-darkBlue"
              name="content"
              id="content"
              v-model="content"
              spellcheck="true"
              required
              cols="60"
              rows="10"
          ></textarea>
        </div>
        <div class="flex flex-col lg:flex-row">
          <p class="inline-block mr-3">Tags :</p>
          <div class="gap-x-3 flex">
            <div>
              <input
                  type="radio"
                  name="tags"
                  id="tech"
                  value="tech"
                  v-model="tagValue"
                  required
              />
              <label for="tech" class="ml-1">Tech</label>
            </div>
            <div>
              <input
                  type="radio"
                  name="tags"
                  id="sante"
                  value="sante"
                  v-model="tagValue"
              />
              <label for="sante" class="ml-1">Santé</label>
            </div>
            <div>
              <input
                  type="radio"
                  name="tags"
                  id="politique"
                  value="politique"
                  v-model="tagValue"
              />
              <label for="politique" class="ml-1">Politique</label>
            </div>
            <div>
              <input
                  type="radio"
                  name="tags"
                  id="mode"
                  value="mode"
                  v-model="tagValue"
              />
              <label for="mode" class="ml-1">Mode</label>
            </div>
            <div>
              <input
                  type="radio"
                  name="tags"
                  id="autre"
                  value="autre"
                  v-model="tagValue"
              />
              <label for="autre" class="ml-1">Autre</label>
            </div>
          </div>
        </div>
        <button
            type="submit"
            class="custom_btn w-fit self-center mb-5 lg:mb-0"
        >
          Ajouter le poste
        </button>
      </div>
    </form>
    <div class="flex-1 lg:ml-5">
      <h1 class="text-2xl">Rendu sur la page :</h1>
      <div
          class="border border-darkBlue max-w-[700px] h-auto min-h-[90%] mt-5 px-5 lg:px-10 break-words "
      >
            <span v-show="tagValue" :class="tagClass" class="p-2 rounded-xl inline-block float-right my-3">
              {{ tagValue }}
            </span>
        <img
            ref="previewImage"
            class="max-h-[200px] w-full object-contain my-5"
        />
        <h2 class="text-xl font-bold mb-8 text-center">{{ title }}</h2>
        <p class="whitespace-pre-line">{{ content }}</p>
      </div>
    </div>
  </section>
  <div class="absolute bottom-16 right-10 bg-green-500 text-center rounded-3xl p-5 opacity-0"
       :class="{active : succesPostSend}">
    <h2>Votre article est bien ajouté ! &#x1F389;</h2>
    <p>Vous pouvez le consultez depuis la page
      <nuxt-link to="/allPosts" class="underline text-blue-600">des postes</nuxt-link>
    </p>
  </div>
</template>
<script setup>
definePageMeta({middleware: 'auth'});

const {data} = useAuth();

const idProfil = data.value.response.id;
const title = ref("");
const content = ref("");
const previewImage = ref(null);
const myForm = ref(null);
const tagValue = ref("");
const tagClass = computed(() => {
  return {
    'bg-blue-400': tagValue.value === 'autre',
    'bg-green-400': tagValue.value === 'tech',
    'bg-red-400': tagValue.value === 'sante',
    'bg-yellow-400': tagValue.value === 'politique',
    'bg-purple-400': tagValue.value === 'mode'
  }
});
const succesPostSend = ref(false);

function addPreviewImg(e) {
  const file = e.target.files[0];

  if (file) {
    const reader = new FileReader();

    reader.onload = (event) => {
      previewImage.value.src = event.target.result;
    };

    reader.readAsDataURL(file);
  }
}

function resetForm() {
  myForm.value.reset()
  title.value = ""
  content.value = ""
  tagValue.value = ""
  previewImage.value.src = ""
}

async function sendPost() {
  const dataForm = new FormData(myForm.value);
  try {
    dataForm.set("idProfil", idProfil);
    const token = document.cookie.split('; ').find(row => row.startsWith('auth.token=')).split('=')[1];
    const response = await fetch("/api/form", {
      method: "POST",
      body: dataForm,
      headers: {
        'Authorization': `Bearer ${token}`
      }
    });
    if (response.ok) {
      succesPostSend.value = true;
      resetForm();
    } else {
      console.error("Error sending post");
    }
  } catch (err) {
    console.log("erreur lors de l'envoi du formulaire", err);
  }
}
</script>

<style scoped>
.active {
  opacity: 1;
  transition: opacity 1s ease-in-out;
}
</style>