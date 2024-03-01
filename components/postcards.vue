<template>
  <a
    href="#"
    class="bg-headerFooter text-white rounded-2xl w-96 h-60 overflow-hidden p-5 border-2 border-headerFooter hover:border-white"
  >
    <h1 class="text-center mb-5 text-2xl">{{ title }}</h1>
    <div class="flex gap-5">
      <p class="allPostsDescritpion">{{ content }}</p>
      <img
        class="w-32 h-32 rounded-xl"
        src="/img/neom-eOWabmCNEdg-unsplash.jpg"
      />
    </div>
  </a>
</template>
<script setup lang="ts">
const propos = defineProps<{
  title: string,
  content : string,
}>()
</script>