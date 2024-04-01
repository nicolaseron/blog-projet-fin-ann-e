<template>
<h1>Hi ! This is my profil page !</h1>
  <pre>{{data}}</pre>
</template>
<script setup lang="ts">
const {data} = useAuth()
</script>


<style scoped>

</style>