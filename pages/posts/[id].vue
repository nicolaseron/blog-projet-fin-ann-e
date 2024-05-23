<template>
  <section v-if="post" class="px-5 md:px-20 m-auto relative">
      <span :class="{
          'bg-blue-400': post.tags === 'autre',
          'bg-green-400': post.tags === 'tech',
          'bg-red-400': post.tags === 'sante',
          'bg-yellow-400': post.tags === 'politique',
          'bg-purple-400': post.tags === 'mode'
                }"
            class="p-2 rounded-xl block ml-auto mt-5 w-fit border-none shadow shadow-black">
             {{ post.tags }}
      </span>
    <nuxt-picture :src="post.img_link"
                  :img-attrs="{class: 'w-full h-auto object-cover max-w-[80%] mx-auto mt-8 mb-2 rounded-xl md:max-w-[700px]'}">
    </nuxt-picture>
    <div class="my-5 italic text-sm text-right">
      <p v-if="post.modified_date">Modifié le {{ new Date(post.modified_date).toLocaleDateString() }} par
        {{ post.pseudo }}</p>
      <p v-else>Crée le {{ formatDate }} par {{ post.pseudo }}</p>
    </div>
    <div v-if="isOwnPost || profilData?.admin" class="text-right space-x-2">
      <button @click="displayModifyInput = !displayModifyInput " class="icon icon-modify text-green-700"></button>
      <button @click="displayDeleteModal= !displayDeleteModal" class="icon icon-delete text-red-600"></button>
    </div>
    <article class="max-w-[1300px] mx-auto">

      <div class="text-center my-14 text-4xl w-full">
        <h1 v-if="!displayModifyInput">{{ post.title }}</h1>
        <input v-else type="text" v-model="newTitle" class="w-full text-2xl text-center">
      </div>
      <div class="mb-10 whitespace-pre-wrap">
        <p v-if="!displayModifyInput" v-text="post.content"></p>
        <textarea v-else v-model="newContent" class="w-full" rows="20" cols="200"></textarea>
      </div>
      <div v-if="displayModifyInput" class="space-x-4 text-center">
        <button @click="modifyPost" class="custom_btn">Modifier</button>
        <button @click="displayModifyInput = !displayModifyInput" class="custom_btn">Annuler</button>
      </div>
      <h2 class="text-2xl underline text-center">Commentaires</h2>
      <div class="space-y-5 my-10">
        <div v-if="comments" v-for="comment in comments" :key="comment.id" class="bg-white p-2 rounded-2xl">
          <div class="flex items-center gap-x-2">
            <i class="icon circle-user text-xl"></i>
            <p class="italic ">{{ comment.pseudo }} à écrit le {{ new Date(comment.date).toLocaleDateString() }} :</p>
          <button v-if="profilData?.admin" class="block ml-auto mr-2 text-red-600" @click="deleteComment(comment.id)"><i class="icon icon-delete"></i></button>
          </div>
          <p class="px-7 mt-1 break-words">{{ comment.comment }}</p>
        </div>
        <div class="flex items-center gap-x-5">
          <input autocomplete="off" type="text" name="comment" placeholder="Ajouter un commentaire" v-model="newComment"
                 class="custom_input custom_input_comment w-full p-2">
          <button class="custom_btn" @click="sendComment">Commenter</button>
        </div>
      </div>
    </article>

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
const comments = ref()
const profilData = data.value?.response;
const isOwnPost = ref();
const displayDeleteModal = ref(false);
const displayModifyInput = ref(false);
const newComment = ref('');

try {
  const {data: postData} = await useFetch(`/api/posts/${route.params.id}`);
  post.value = postData.value?.post;
  comments.value = postData.value?.comments;
  formatDate.value = new Date(post.value?.created_date).toLocaleDateString();
  isOwnPost.value = status.value === 'authenticated' && profilData.id === Number(post.value?.id_profil);
} catch (error) {
  console.error("Erreur lors de la récupération des données", error);
}
const newTitle = ref(post.value.title);
const newContent = ref(post.value.content);
const idPost = post.value.id;
const token = ref()

async function deletePost() {
  try {
    token.value = document.cookie.split('; ').find(row => row.startsWith('auth.token='))?.split('=')[1];
    if (!token.value) return;
    await $fetch(`/api/posts/delete/${idPost}`, {
      method: "DELETE",
      headers: {
        'Authorization': `Bearer ${token.value}`
      },
      body: {isAdmin: profilData.admin, isOwnPost: isOwnPost.value}
    })
    await router.push("../allPosts")
  } catch (error) {
    console.log(error)
  }
}

async function modifyPost() {
  if ((isOwnPost.value || profilData.admin) && (post.value.title !== newTitle.value || post.value.content !== newContent.value)) {
    token.value = document.cookie.split('; ').find(row => row.startsWith('auth.token='))?.split('=')[1];
    if (!token.value) return;
    try {
      await $fetch(`/api/posts/put/${idPost}`, {
        method: "PUT",
        headers: {
          'Authorization': `Bearer ${token.value}`
        },
        body: {title: newTitle.value, content: newContent.value, isAdmin: profilData.admin, isOwnPost: isOwnPost.value}
      })
      location.reload()
    } catch (error) {
      console.log(error)
    }
  }
}

async function sendComment() {
  const dataComment = {
    comment: newComment.value,
    user: profilData.id,
    post: idPost
  };
  try {
    await $fetch(`/api/comments/${idPost}.post.ts`, {
      method: "POST",
      body: dataComment,
    })
    location.reload();
  } catch (error) {
    console.log(error)
  }
}

async function deleteComment(idComment:number) {
  try {
    await $fetch(`/api/comments/delete/${idComment}`, {
      method: "DELETE",
      body: {isAdmin: profilData.admin , idComment}
    })
    location.reload();
  } catch (error) {
    console.log(error)
  }
}
</script>