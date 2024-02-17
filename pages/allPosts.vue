<template>
  <main>
    <the-header></the-header>
    <section class="bg-black p-12 text-white">
      <div class="flex flex-col items-center justify-between md:flex-row">
        <a href="/" class="custom_btn w-fit order-1 md:order-2"
          >Ajouter vos propes postes</a
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
        class="text-2xl font-bold text-blue100 mb-5 border-b inline-block border-blue100"
      >
        Fil d'actualité :
      </h1>
      <div class="flex gap-10 flex-wrap justify-center text-blue400">
        <post-cards v-for="item in 15" :key="item"></post-cards>
      </div>
    </section>
    <the-footer></the-footer>
  </main>
</template>
<script></script>
<style></style>
