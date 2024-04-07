<template>
  <main class="flex flex-col min-h-svh text-darkBlue">
    <the-header></the-header>
    <section class="bg-background p-12 text-darkBlue flex-1">
      <div class="flex flex-col items-center justify-between md:flex-row">
        <nuxt-link to="addPost" class="custom_btn w-fit order-1 md:order-2"
        >Ajouter vos propes postes
        </nuxt-link
        >
        <div class="flex flex-col gap-5 my-5 order-2 md:order-1">
          <div class="flex flex-col gap-3 md:flex-row md:w-full">
            <p class="text-nowrap">Recherchr par titre de poste : </p>
            <input
                type="search"
                name="searchPost"
                id="searchPost"
                class="custom_input md:w-full"
                placeholder="Ex : Javascript"
                @input="searchPost"
            />
          </div>
          <div class="flex flex-col gap-3 items-center md:flex-row">
            <p>Rechercher par tags :</p>
            <div class="flex gap-x-3">
              <button @click="toggleFilter('tech')" class="custom_btn"
                      :class="{ 'focusBtn': filterTag === 'tech' && !filterText.length }">Tech
              </button>
              <button @click="toggleFilter('sante')" class="custom_btn"
                      :class="{ 'focusBtn': filterTag === 'sante' && !filterText.length }">Santé
              </button>
              <button @click="toggleFilter('politique')" class="custom_btn"
                      :class="{ 'focusBtn': filterTag === 'politique' && !filterText.length }">Politique
              </button>
              <button @click="toggleFilter('mode')" class="custom_btn"
                      :class="{ 'focusBtn': filterTag === 'mode' && !filterText.length }">Mode
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
      <div class="flex gap-10 flex-wrap justify-center">
        <PostCards
            v-if="postToDisplay.length"
            v-for="(post,i) in postToDisplay"
            :key="post.id"
            :title="post.title"
            :content="post.content"
            :src="post.img_link"
            :to="`/posts/${post.id}`"
        >
          <span :class="{
                  'bg-blue-400': post.tags === 'politique',
                  'bg-red-400': post.tags === 'mode',
                  'bg-green-400': post.tags === 'tech',
                  'bg-yellow-400': post.tags === 'sante'
                }"
                class="p-2 rounded-xl block ml-auto w-fit my-3">
             {{ post.tags }}
          </span>
        </PostCards>
        <div v-else>
          <p>Désoler il n'y a aucun poste à afficher !</p>
        </div>
      </div>
    </section>
    <the-footer></the-footer>
  </main>
</template>
<script setup lang="ts">
const {data} = useFetch("/api/posts");
console.log(data.value)
const filterTag = ref();
const filterText = ref("")

function searchPost(e: Event) {
  filterText.value = (e.target as HTMLInputElement).value.toLowerCase()
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
    return data.value
  } else if (filterText.value) {
    filterTag.value = null;
    if (data.value) {
      return data.value.filter((post: { title: string }) => post.title.toLowerCase().includes(filterText.value))
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
  box-shadow: inset 0 -3em 0 0 #374158;
  color: white;
}
</style>
