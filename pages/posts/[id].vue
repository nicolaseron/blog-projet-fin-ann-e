<template>
  <main class="flex flex-col min-h-svh text-darkBlue max-w-[2500px]">
    <the-header></the-header>
    <section v-if="data" class="px-5 md:px-20">
      <span :class="{
                  'bg-blue-400': data.tags === 'politique',
                  'bg-red-400': data.tags === 'mode',
                  'bg-green-400': data.tags === 'tech',
                  'bg-yellow-400': data.tags === 'sante'
                }"
            class="p-2 rounded-xl block ml-auto mt-5 w-fit">
             {{ data.tags }}
      </span>
      <nuxt-picture :src="data.img_link"
                    :img-attrs="{class: 'w-full h-full object-cover max-w-[80%] mx-auto my-10 rounded-xl md:max-w-[700px]'}">
      </nuxt-picture>
      <h1 class="text-center text-4xl">{{ data.title }}</h1>
      <p class="text-right my-14 italic text-sm">Crée le {{ formatDate }} par {{ data.pseudo }}</p>
      <p v-text="data.content" class="mb-10 max-w-[1500px] m-auto"></p>
    </section>
    <the-footer></the-footer>
  </main>
</template>

<script setup lang="ts">

const route = useRoute();
const data = ref();
const formatDate = ref('');
onBeforeMount(async () => {
  try {
    const response = await fetch(`/api/posts/${route.params.id}`);
    data.value = await response.json();
    formatDate.value = new Date(data.value.created_date).toLocaleDateString();
  } catch (error) {
    console.error("Erreur lors de la récupération des données");
  }
})
</script>