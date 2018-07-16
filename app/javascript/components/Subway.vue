<template>
  <div>
    <div class="select is-rounded is-large is-fullwidth">
      <select :value="getCurrentSubwayStop" @change="fetchSubwayArrivalsFromApi($event.target.value)">
        <option value="">---</option>
        <option v-for="(stop, index) in getAllSubwayStops" :value="stop[1]" v-bind:key="index">
          {{stop[2] + ' - ' + stop[3]}}
        </option>
      </select>
    </div>
    <hr />
    <div class="columns">
      <div class="column">
        <subway-arrival :arrivals="getNorthboundSubwayArrivals" direction="Northbound"></subway-arrival>
      </div>
      <div class="column">
        <subway-arrival :arrivals="getSouthboundSubwayArrivals" direction="Southbound"></subway-arrival>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import SubwayArrival from './SubwayArrival.vue'
export default {
  data() {
    return {
      timer: ''
    }
  },
  components: {
    'subway-arrival': SubwayArrival
  },
  computed: {
    ...mapGetters(['getAllSubwayStops', 'getCurrentSubwayStop', 'getNorthboundSubwayArrivals', 'getSouthboundSubwayArrivals'])
  },
  methods: {
    ...mapActions(['fetchSubwayArrivalsFromApi']),
    populateSubwayStops() {
      this.$store.dispatch('fetchAllSubwayStopsFromApi')
    },
    refreshSubwayArrivals() {
      this.$store.dispatch('fetchSubwayArrivalsFromApi', this.$store.state.currentSubwayStop)
    }
  },
  mounted() {
    if (this.$store.state.allSubwayStops.length < 1) {
      this.populateSubwayStops()
    }
    this.refreshSubwayArrivals()
    this.timer = setInterval(() => { this.refreshSubwayArrivals() }, 30000)
  },
  beforeDestroy() {
    clearInterval(this.timer)
  }
}
</script>
