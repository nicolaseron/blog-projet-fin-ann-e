<template>
  <nuxt-link to="/">
    <div
      class="bg-headerFooter text-white rounded-2xl overflow-hidden p-5 w-[300px] h-[315px] sm:w-[500px]"
    >
      <h1 class="text-center mb-5 text-2xl">{{ title }}</h1>
      <div class="flex gap-5 justify-between">
        <p class="text-wrap break-words w-[50%]">{{ content }}</p>
        <nuxt-picture
          class="min-w-32 h-auto rounded-xl flex-1"
          src="/img/neom-eOWabmCNEdg-unsplash.jpg"
        >
        </nuxt-picture>
      </div>
    </div>
  </nuxt-link>
</template>
<script setup lang="ts">
const props = defineProps<{
  title: string;
  content: string;
}>();
</script>
