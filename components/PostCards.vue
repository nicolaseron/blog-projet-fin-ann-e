<template>
  <nuxt-link :to="to">
    <div
        class="bg-headerFooter text-white rounded-2xl overflow-hidden p-5 w-[300px] h-[310px] sm:w-[500px] border-2 border-headerFooter hover:bg-darkBlue"
    >
      <slot></slot>
      <h1 class="text-center mb-5 mt-4 text-2xl">{{ title }}</h1>
      <div class="flex gap-5 justify-between">
        <p class="text-wrap break-words w-[50%] line-clamp-5">{{ content }}</p>
        <nuxt-picture class="max-w-40 max-h-40 rounded-xl flex-1" :src="src"
                      :img-attrs="{class : 'h-full w-full object-contain'}">
        </nuxt-picture>
      </div>
    </div>
  </nuxt-link>
</template>
<script setup lang="ts">
const props = defineProps<{
  title: string;
  content: string;
  src: string;
  to: string;
}>();
</script>
