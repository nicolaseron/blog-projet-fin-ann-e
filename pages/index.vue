<template>
  <div class="flex flex-col min-h-svh">
    <the-header></the-header>
    <main class="relative flex-1 h-full w-full">
      <video
          src="/video/184427 (1080p).mp4"
          class="absolute top-0 left-0 w-full h-full pointer-events-none object-cover"
          preload="auto"
          muted
          playsinline
          loop
          autoplay
      ></video>
      <h1
          id="title"
          ref="title"
          class="absolute top-5 left-5 text-3xl text-white sm:px-5"
          :class="{'hide-cursor' : !isCursorVisible}"
      ></h1>
    </main>
    <the-footer></the-footer>
  </div>
</template>

<script setup>
const text = `Bienvenue sur le blog Coffee Time !`;
const title = ref("");
const isCursorVisible = ref(true);

function typeWriter(word, index) {
  if (index < word.length) {
    setTimeout(() => {
      title.value.innerHTML += `<span>${word[index]}</span>`;
      typeWriter(text, index + 1);
    }, 100);
  } else {
    isCursorVisible.value = false;
  }
}

onMounted(() => {
  typeWriter(text, 0);
});
</script>
<style scoped>
#title::after {
  content: "";
  position: absolute;
  width: 1px;
  height: 100%;
  background-color: #fff;
  top: 0;
  right: 0;
  animation: cursor 1s infinite;
}
.hide-cursor::after{
  display: none;
}

@keyframes cursor {
  0% {
    opacity: 0;
  }
  50% {
    opacity: 1;
  }
  100% {
    opacity: 0;
  }
}
</style>
