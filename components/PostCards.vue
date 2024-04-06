<template>
  <div
      class="bg-headerFooter text-white rounded-2xl overflow-hidden p-5 w-[300px] h-[315px] sm:w-[500px] border-2 border-headerFooter hover:bg-darkBlue hover:border-white"
  >
    <nuxt-link :to="to">
      <slot></slot>
      <h1 class="text-center mb-5 text-2xl">{{ title }}</h1>
      <div class="flex gap-5 justify-between">
        <p class="text-wrap break-words w-[50%]">{{ content }}</p>
        <nuxt-picture class="max-w-28 h-auto rounded-xl flex-1" :src="src"
                      :img-attrs="{class : 'h-full w-full object-contain'}">
        </nuxt-picture>
      </div>
    </nuxt-link>
  </div>
</template>
<script setup lang="ts">
const props = defineProps<{
  title: string;
  content: string;
  src: string;
  to: string;
}>();
</script>
