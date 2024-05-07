<template>
  <section v-if="post" class="px-5 md:px-20 m-auto relative">
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
                  :img-attrs="{class: 'w-full h-auto object-cover max-w-[80%] mx-auto mt-8 mb-2 rounded-xl md:max-w-[700px]'}">
    </nuxt-picture>
    <div v-if="isOwnPost || dataProfil?.admin" class="text-right space-x-2">
      <button class="icon icon-modify text-green-700"></button>
      <button @click="displayDeleteModal= !displayDeleteModal" class="icon icon-delete text-red-600"></button>
    </div>
    <h1 class="text-center my-14 text-4xl">{{ post.title }}</h1>
    <p v-text="post.content" class="mb-10 max-w-[1500px] m-auto whitespace-pre-wrap"></p>
    <p class="my-5 italic text-sm text-right">Crée le {{ formatDate }} par {{ post.pseudo }}</p>
    <div id="popup-modal" tabindex="-1" v-if="displayDeleteModal"
         class="overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 justify-center items-center w-full md:inset-0 h-[calc(100%-1rem)] max-h-full">
      <div class="relative top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 p-4 w-full max-w-md max-h-full">
        <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
          <button type="button" @click="displayDeleteModal = !displayDeleteModal"
                  class="absolute top-3 end-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm w-8 h-8 ms-auto inline-flex justify-center items-center dark:hover:bg-gray-600 dark:hover:text-white"
                  data-modal-hide="popup-modal">
            <svg class="w-3 h-3" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 14 14">
              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                    d="m1 1 6 6m0 0 6 6M7 7l6-6M7 7l-6 6"/>
            </svg>
            <span class="sr-only" @click="displayDeleteModal = !displayDeleteModal">Fermer la modal</span>
          </button>
          <div class="p-4 md:p-5 text-center">
            <svg class="mx-auto mb-4 text-gray-400 w-12 h-12 dark:text-gray-200" aria-hidden="true"
                 xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 20 20">
              <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                    d="M10 11V6m0 8h.01M19 10a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"/>
            </svg>
            <h3 class="mb-5 text-lg font-normal text-gray-500 dark:text-gray-400">Êtes-vous sûr de vouloir supprimer cet
              article ?</h3>
            <button data-modal-hide="popup-modal" type="button" @click="deletePost"
                    class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 dark:focus:ring-red-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center">
              Oui je suis sûr.
            </button>
            <button data-modal-hide="popup-modal" @click="displayDeleteModal = !displayDeleteModal" type="button"
                    class="py-2.5 px-5 ms-3 text-sm font-medium text-gray-900 focus:outline-none bg-white rounded-lg border border-gray-200 hover:bg-gray-100 hover:text-blue-700 focus:z-10 focus:ring-4 focus:ring-gray-100 dark:focus:ring-gray-700 dark:bg-gray-800 dark:text-gray-400 dark:border-gray-600 dark:hover:text-white dark:hover:bg-gray-700">
              Retour
            </button>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">

const router = useRouter()
const route = useRoute();
const formatDate = ref('');
const {status, data} = useAuth();
const post = ref();
const dataProfil = data.value?.response;
const isOwnPost = ref();
const displayDeleteModal = ref(false);
try {
  const {data: postData} = await useFetch(`/api/posts/${route.params.id}`);
  post.value = postData.value;
  formatDate.value = new Date(post.value?.created_date).toLocaleDateString();
  isOwnPost.value = status.value === 'authenticated' && dataProfil.id === Number(post.value?.id_profil);
} catch (error) {
  console.error("Erreur lors de la récupération des données");
}

async function deletePost() {
  try {
    const postToDelete = post.value.id;
    const token = document.cookie.split('; ').find(row => row.startsWith('auth.token=')).split('=')[1];
    if (!token)return;
    await $fetch(`/api/posts/delete/${postToDelete}`, {
      method: "DELETE",
      headers: {
        'Authorization': `Bearer ${token}`
      },
      body: {isAdmin : dataProfil.admin, isOwnPost: isOwnPost.value}
    })
    await router.push("../allPosts")
  } catch (error) {
    console.log(error)
  }
}

</script>