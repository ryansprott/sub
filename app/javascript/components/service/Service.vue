<template>
  <div>
    <div v-for="(item, ndx) in getServiceStatus" :key="ndx" class="content">
      <hr />
      <div v-for="(affected, i) in item.affects" :key="i">
        {{ affected.LineRef }}
        {{ affected.DirectionRef }}
      </div>
      <div v-html="item.long_description"></div>
    </div>
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
    this.timer = setInterval(() => { this.refreshServiceStatus() }, 300000)
  },
  beforeDestroy() {
    clearInterval(this.timer)
  }
}
</script>
