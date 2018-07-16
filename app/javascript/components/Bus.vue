<template>
  <div class="columns">
    <div class="column">
      <div class="select is-rounded is-large is-fullwidth" v-cloak>
        <select :value="getCurrentBusStop" @change="fetchBusArrivalsFromApi($event.target.value)">
          <option value="">---</option>
          <option v-for="stop in getAllBusStops" :value="stop[1]" v-bind:key="stop[0]">
            {{stop[1] + ' - ' + stop[3] + ' - ' + stop[4]}}
          </option>
        </select>
      </div>
      <div class="column is-fullwidth">
        <bus-arrival :arrivals='getBusArrivals'></bus-arrival>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import BusArrival from './BusArrival.vue'
export default {
  data() {
    return {
      timer: ''
    }
  },
  components: {
    'bus-arrival': BusArrival
  },
  methods: {
    ...mapActions(['fetchBusArrivalsFromApi']),
    populateBusStops() {
      this.$store.dispatch('fetchAllBusStopsFromApi')
    },
    refreshBusArrivals() {
      this.$store.dispatch('fetchBusArrivalsFromApi', this.$store.state.currentBusStop)
    }
  },
  computed: {
    ...mapGetters(['getAllBusStops', 'getCurrentBusStop', 'getBusArrivals'])
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
