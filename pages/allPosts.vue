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
          <div class="flex flex-col gap-y-5 md:flex-row md:w-full">
            <input
                type="search"
                name="searchPost"
                id="searchPost"
                class="custom_input md:w-full"
                placeholder="Ex : Javascript"
            />
            <button class="ml-3 custom_btn text-nowrap">
              Rechercher par titre de poste
            </button>
          </div>
          <div class="flex flex-col gap-3 items-center md:flex-row">
            <p>Rechercher par tags :</p>
            <div class="flex gap-x-3">
              <button class="custom_btn">Tech</button>
              <button class="custom_btn">actualité</button>
              <button class="custom_btn">Politique</button>
              <button class="custom_btn">Mode</button>
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
            v-for="post in data"
            :key="post.id"
            :title="post.title"
            :content="post.content"
            :src="post.img_link"
        >
          <div
              class="flex gap-x-2 justify-end text-black flex-wrap gap-y-2 lg:gap-y-0 mb-2"
          >
            <span v-if="post.id_tags.includes(1)" class="bg-yellow-300 p-2 rounded-xl"
            >Tech</span
            >
            <span v-if="post.id_tags.includes(2)" class="bg-red-500 p-2 rounded-xl"
            >Santé</span
            >
            <span v-if="post.id_tags.includes(3)" class="bg-blue-400 p-2 rounded-xl"
            >Politique</span
            >
            <span v-if="post.id_tags.includes(4)" class="bg-pink-400 p-2 rounded-xl"
            >Mode</span
            >
          </div>
        </PostCards>
      </div>
    </section>
    <the-footer></the-footer>
  </main>
</template>
<script setup lang="ts">
const {data} = useFetch("/api/posts");
console.log(data)
</script>
