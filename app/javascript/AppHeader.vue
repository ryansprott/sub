<template>
  <nav class="nav has-shadow">
    <div class="container">
      <router-link to="/" exact>
        <img src="http://bit.ly/vue-img" />
      </router-link>
      <router-link class="nav-item is-tab" to="/something" exact>
        {{getStop}}
      </router-link>
    </div>
  </nav>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters(['getStop', 'setStop'])
  }
}
</script>
