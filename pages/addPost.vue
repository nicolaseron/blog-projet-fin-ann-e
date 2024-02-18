<template>
  <main class="flex flex-col min-h-svh text-white">
    <the-header></the-header>
    <section class="bg-black flex-1 flex p-10">
      <form action="#" class="flex-1">
        <div class="flex flex-col gap-y-5">
          <div class="flex flex-col gap-y-3">
            <label for="image"
              >Choisissez une image
              <span class="text-xs text-gray-500"
                >(format accepté : '.png','.jpg','.jpeg','.webp')</span
              >
              :
            </label>
            <input
              type="file"
              name="image"
              id="image"
              accept=".png,.jpg,.jpeg,.webp"
              @change="addPreviewImg"
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
            <label for="content">Contenu du poste :</label>
            <textarea
              class="bg-transparent border border-blue100"
              name="content"
              id="content"
              v-model="content"
              spellcheck="true"
              required
              cols="60"
              rows="10"
            ></textarea>
          </div>
          <div class="flex">
            <p class="inline-block mr-3">Tags :</p>
            <div class="gap-x-3 flex">
              <div>
                <input
                  type="checkbox"
                  name="tech"
                  id="tech"
                  value="tech"
                  v-model="techIschecked"
                />
                <label for="tech" class="ml-1">Tech</label>
              </div>
              <div>
                <input
                  type="checkbox"
                  name="sante"
                  id="sante"
                  value="sante"
                  v-model="healthIschecked"
                />
                <label for="sante" class="ml-1">Santé</label>
              </div>
              <div>
                <input
                  type="checkbox"
                  name="politique"
                  id="politique"
                  value="politique"
                  v-model="politicIschecked"
                />
                <label for="politique" class="ml-1">Politique</label>
              </div>
              <div>
                <input
                  type="checkbox"
                  name="mode"
                  id="mode"
                  value="mode"
                  v-model="modeIschecked"
                />
                <label for="mode" class="ml-1">Mode</label>
              </div>
            </div>
          </div>
          <button type="submit" class="custom_btn w-fit self-center">
            Ajouter le poste
          </button>
        </div>
      </form>
      <div class="flex-1">
        <h1 class="text-2xl">Rendu sur la page :</h1>
        <div
          class="border border-blue100 max-w-[700px] h-auto min-h-[90%] mt-5 p-10 break-words"
        >
          <div class="flex gap-x-2 justify-end text-black">
            <span v-show="techIschecked" class="bg-yellow-300 p-2 rounded-xl"
              >Tech</span
            >
            <span v-show="healthIschecked" class="bg-gray-400 p-2 rounded-xl"
              >Santé</span
            >
            <span v-show="politicIschecked" class="bg-blue-400 p-2 rounded-xl"
              >Politique</span
            >
            <span v-show="modeIschecked" class="bg-pink-400 p-2 rounded-xl"
              >Mode</span
            >
          </div>
          <img
            ref="previewImage"
            class="max-h-[300px] w-full object-cover my-5"
          />
          <h2 class="text-xl font-bold mb-8">{{ title }}</h2>
          <p class="whitespace-pre-line">{{ content }}</p>
        </div>
      </div>
    </section>
    <the-footer></the-footer>
  </main>
</template>
<script setup>
const title = ref("");
const content = ref("");
const techIschecked = ref(false);
const healthIschecked = ref(false);
const politicIschecked = ref(false);
const modeIschecked = ref(false);
const previewImage = ref(null);
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
</script>
