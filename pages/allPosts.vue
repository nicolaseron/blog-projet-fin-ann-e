<template>
  <section class="text-darkBlue w-full">
    <div class="p-12">
      <div class="flex flex-col items-center gap-x-10 justify-between md:flex-row">
        <div class="flex flex-col gap-5 my-5 order-2 md:order-1">
          <div class="flex flex-col gap-3 md:flex-row md:w-full">
            <p class="text-nowrap">Rechercher par titre de poste : </p>
            <input
                type="search"
                name="searchPost"
                id="searchPost"
                class="custom_input md:w-full"
                @input="searchPost"
                autocomplete="off"
            />
          </div>
          <div class="flex flex-col gap-3 items-center md:flex-row">
            <p>Rechercher par tags :</p>
            <div class="flex gap-x-3">
              <button @click="toggleFilter('tech')"
                      class="bg-green-400 border-none shadow shadow-black p-2 rounded-lg hover:text-white hover:bg-darkBlue transition-colors duration-300"
                      :class="{ 'focusBtn': filterTag === 'tech' && !filterText.length }">Tech
              </button>
              <button @click="toggleFilter('sante')"
                      class="bg-red-400 border-none shadow shadow-black p-2 rounded-lg hover:text-white hover:bg-darkBlue transition-colors duration-300"
                      :class="{ 'focusBtn': filterTag === 'sante' && !filterText.length }">Santé
              </button>
              <button @click="toggleFilter('politique')"
                      class="bg-yellow-400 border-none shadow shadow-black p-2 rounded-lg hover:text-white hover:bg-darkBlue transition-colors duration-300"
                      :class="{ 'focusBtn': filterTag === 'politique' && !filterText.length }">Politique
              </button>
              <button @click="toggleFilter('mode')"
                      class="bg-purple-400 border-none shadow shadow-black p-2 rounded-lg hover:text-white hover:bg-darkBlue transition-colors duration-300"
                      :class="{ 'focusBtn': filterTag === 'mode' && !filterText.length }">Mode
              </button>
              <button @click="toggleFilter('autre')"
                      class="bg-blue-400 border-none shadow shadow-black p-2 rounded-lg hover:text-white hover:bg-darkBlue transition-colors duration-300"
                      :class="{ 'focusBtn': filterTag === 'autre' && !filterText.length }">Autre
              </button>
            </div>
          </div>
        </div>
      </div>
      <h1
          class="text-2xl font-bold mb-10 border-b inline-block border-darkBlue"
      >
        Fil d'actualité :
      </h1>
      <div class="flex gap-8 flex-wrap justify-center">
        <PostCards
            v-for="(post) in postToDisplay || []"
            :key="post.id"
            :title="post.title"
            :content="post.content"
            :src="post.img_link"
            :to="`/posts/${post.id}`"
        >
          <span :class="{
            'bg-blue-400': post.tags === 'autre',
            'bg-green-400': post.tags === 'tech',
            'bg-red-400': post.tags === 'sante',
            'bg-yellow-400': post.tags === 'politique',
            'bg-purple-400': post.tags === 'mode'
                        }"
                class="p-2 rounded-xl text-black block ml-auto w-fit">
             {{ post.tags }}
          </span>
        </PostCards>
        <div v-if="!postToDisplay || postToDisplay.length === 0">
          <p>Désoler il n'y a aucun poste à afficher !</p>
        </div>
      </div>
    </div>
    <nuxt-link to="addPost"
               class="bg-green-600 sticky bottom-14 mr-5 ml-auto flex justify-center items-center rounded-full w-12 h-12">
      <i class="icon icon-add text-white text-2xl"></i>
    </nuxt-link>
  </section>
</template>
<script setup lang="ts">
const {data} = useFetch("/api/posts");
const filterTag = ref();
const filterText = ref("");

function searchPost(e: Event) {
  filterText.value = (e.target as HTMLInputElement).value.toLowerCase();
}

function toggleFilter(tag: string) {
  if (filterTag.value === tag) {
    filterTag.value = null;
  } else {
    filterTag.value = tag;
  }
}

const postToDisplay = computed(() => {
  if (!filterText.value.length && !filterTag.value) {
    return data.value;
  } else if (filterText.value) {
    filterTag.value = null;
    if (data.value) {
      return data.value.filter((post: { title: string }) => post.title.toLowerCase().includes(filterText.value));
    }
  } else if (filterTag.value) {
    if (data.value) {
      return data.value.filter((post: { tags: string; }) => post.tags.toLowerCase().includes(filterTag.value));
    }
  }
});
</script>

<style scoped>
.focusBtn {
  box-shadow: inset 0 -3em 0 0 #112D4E;
  color: white;
}
</style>
