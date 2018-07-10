<template>
  <div id="app-layout">
    <app-header></app-header>
    <router-view></router-view>
    <app-footer></app-footer>
  </div>
</template>

<script>
import AppHeader from "./AppHeader.vue"
import AppFooter from "./AppFooter.vue"
export default {
  components: {
    "app-header": AppHeader,
    "app-footer": AppFooter   
  }
}
</script>
