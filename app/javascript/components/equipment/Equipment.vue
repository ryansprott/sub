<template>
  <div>
    <div v-for="(status, ndx) in getEquipmentStatus" :key="ndx">
      <div>{{status.station}} ({{status.borough}}) - {{status.trainno}}</div>
      <div>{{status.serving}}</div>
      <div>{{status.reason}}</div>
      <div>From {{status.outagedate}} to {{status.estimatedreturntoservice}}</div>
      <hr />
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
    ...mapGetters(['getEquipmentStatus'])
  },
  methods: {
    refreshEquipmentStatus() {
      this.$store.dispatch('fetchEquipmentStatusFromApi')
    }
  },
  mounted() {
    this.refreshEquipmentStatus()
    this.timer = setInterval(() => { this.refreshEquipmentStatus() }, 30000)
  },
  beforeDestroy() {
    clearInterval(this.timer)
  }
}
</script>
