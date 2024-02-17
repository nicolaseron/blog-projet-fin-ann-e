<template>
  <main>
    <the-header></the-header>
    <section class="bg-black p-12 text-white">
      <h1 class="text-3xl text-center font-bold text-blue100">
        Fil d'actualité
      </h1>
      <div class="flex justify-between items-center flex-col gap-5 my-10">
        <div
          class="flex flex-col justify-center items-center gap-y-5 sm:flex-row"
        >
          <input
            type="search"
            name="searchPost"
            id="searchPost"
            class="custom_input min-w-[200px]"
            placeholder="Ex : Javascript"
          />
          <button class="ml-3 custom_btn">Rechercher des postes</button>
        </div>
        <div class="flex flex-col gap-3 items-center sm:flex-row">
          <p>Rechercher par tags :</p>
          <div class="flex gap-x-3">
            <button class="custom_btn">Tech</button>
            <button class="custom_btn">actualité</button>
            <button class="custom_btn">Politique</button>
            <button class="custom_btn">Mode</button>
          </div>
        </div>
      </div>
      <div class="flex gap-10 flex-wrap justify-center text-blue400">
        <Postcards v-for="item in 15" :key="item"></Postcards>
      </div>
    </section>
    <the-footer></the-footer>
  </main>
</template>
<script>
import Postcards from "~/components/postcards.vue";
</script>
<style></style>
