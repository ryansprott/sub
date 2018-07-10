<template>
  <div id="app-layout">
    <app-header></app-header>
    <category></category>
    <app-footer></app-footer>
  </div>
</template>

<script>
import AppHeader from "./AppHeader.vue"
import AppFooter from "./AppFooter.vue"
import Category from "./Category.vue"
export default {
  components: {
    "app-header": AppHeader,
    "app-footer": AppFooter,
    "category": Category
  }
}
</script>
