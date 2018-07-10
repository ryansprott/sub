<template>
  <div>
    <h1>Something else</h1>
    <button class="btn btn-success" @click="setStop('foobar')">Blah</button>
  </div>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  methods: {
    ...mapActions(['setStop'])
  }
}
</script>
