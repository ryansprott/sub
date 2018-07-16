<template>
  <div>
    <bus-select></bus-select>
    <hr />
    <bus-arrival
      :arrivals='getBusArrivals'>
    </bus-arrival>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import BusArrival from './BusArrival.vue'
import BusSelect from './BusSelect.vue'
export default {
  data() {
    return {
      timer: ''
    }
  },
  components: {
    'bus-arrival': BusArrival,
    'bus-select': BusSelect
  },
  computed: {
    ...mapGetters(['getBusArrivals'])
  },
  methods: {
    populateBusStops() {
      this.$store.dispatch('fetchAllBusStopsFromApi')
    },
    refreshBusArrivals() {
      this.$store.dispatch('fetchBusArrivalsFromApi', this.$store.state.currentBusStop)
    }
  },
  mounted() {
    if (this.$store.state.allBusStops.length < 1) {
      this.populateBusStops()
    }
    this.refreshBusArrivals()
    this.timer = setInterval(() => { this.refreshBusArrivals() }, 30000)
  },
  beforeDestroy() {
    clearInterval(this.timer)
  }
}
</script>
