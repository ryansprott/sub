<template>
  <div>
  </div>
</template>
<script>
import { mapActions, mapGetters } from 'vuex'
export default {
  data() {
    return {
      timer: ''
    }
  },
  computed: {
    ...mapGetters(['getServiceStatus'])
  },
  methods: {
    refreshServiceStatus() {
      this.$store.dispatch('fetchServiceStatusFromApi')
    },
  },
  mounted() {
    this.refreshServiceStatus()
    this.timer = setInterval(() => { this.refreshServiceStatus() }, 30000)
  },
  beforeDestroy() {
    clearInterval(this.timer)
  }
}
</script>
