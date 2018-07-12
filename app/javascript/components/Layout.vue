<template>
  <div id="app-layout">
    <app-header></app-header>
    <router-view></router-view>
  </div>
</template>

<script>
import AppHeader from "./AppHeader.vue"
export default {
  components: {
    "app-header": AppHeader
  }
}
</script>

<style lang="scss" src="bulma"></style>
