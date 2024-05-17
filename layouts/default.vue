<template>
  <main class="flex flex-col min-h-svh text-darkBlue max-w-[2500px]">
    <the-header></the-header>
    <div class="relative flex flex-1 h-full w-full bg-background">
      <slot></slot>
    </div>
    <the-footer></the-footer>
  </main>
</template>

<style scoped>
.bg-background {
  background-image: linear-gradient(-225deg, #7085B6 0%, #87A7D9 50%, #DEF3F8 100%);
}
</style>