<template>
  <div>
    <div v-for="(item, ndx) in getEquipmentStatus" :key="ndx" class="content">
      <h1>{{ndx}}</h1>
      <div v-for="(status, i) in item" :key="i">
        <div class="card">
          <header class="card-header">
            <p class="card-header-title">{{status.station}}</p>
          </header>
          <div class="card-content">
            <div class="content">
              <p>{{status.serving}}</p>
              <p>From {{status.outage_start}} to {{status.outage_end}}</p>
            </div>
          </div>
          <footer class="card-footer">
            <div class="card-footer-item">{{status.trains}}</div>
            <div class="card-footer-item">{{status.reason}}</div>
          </footer>
        </div>
      </div>
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
