<template>
  <section v-if="post" class="px-5 md:px-20 m-auto">
      <span :class="{
          'bg-blue-400': post.tags === 'autre',
          'bg-green-400': post.tags === 'tech',
          'bg-red-400': post.tags === 'sante',
          'bg-yellow-400': post.tags === 'politique',
          'bg-purple-400': post.tags === 'mode'
                }"
            class="p-2 rounded-xl block ml-auto mt-5 w-fit">
             {{ post.tags }}
      </span>
    <nuxt-picture :src="post.img_link"
                  :img-attrs="{class: 'w-full h-auto object-cover max-w-[80%] mx-auto my-8 rounded-xl md:max-w-[700px]'}">
    </nuxt-picture>
    <div v-if="isOwnPost" class="text-right space-x-2">
      <button class="icon icon-modify text-green-700"></button>
      <button class="icon icon-delete text-red-600"></button>
    </div>
    <h1 class="text-center text-4xl">{{ post.title }}</h1>
    <p class="text-right my-14 italic text-sm">Crée le {{ formatDate }} par {{ post.pseudo }}</p>
    <p v-text="post.content" class="mb-10 max-w-[1500px] m-auto"></p>
  </section>
</template>

<script setup lang="ts">

const route = useRoute();
const formatDate = ref('');
const {status, data} = useAuth();
const post = ref()
const dataProfil = data.value?.response;
const isOwnPost = ref()
try {
  const {data: postData} = await useFetch(`/api/posts/${route.params.id}`);
  post.value = postData.value
  formatDate.value = new Date(post.value?.created_date).toLocaleDateString();
  isOwnPost.value = computed(() => status.value === 'authenticated' && dataProfil.id === Number(post.value?.id_profil))
} catch (error) {
  console.error("Erreur lors de la récupération des données");
}
</script>