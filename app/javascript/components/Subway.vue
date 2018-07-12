<template>
  <div>    
    <div class="select is-rounded is-large is-fullwidth">
      <select :value="getCurrentStop" @change="fetchArrivalsFromApi($event.target.value)">
        <option value="">---</option>
        <option v-for="(stop, index) in getAllStops" :value="stop[1]" v-bind:key="index">
          {{stop[2] + ' - ' + stop[3]}}
        </option>
      </select>
    </div>
    <hr />
    <div class="columns">
      <div class="column">
        <subway-arrival :arrivals="getNorthboundArrivals" direction="Northbound"></subway-arrival>
      </div>
      <div class="column">
        <subway-arrival :arrivals="getSouthboundArrivals" direction="Southbound"></subway-arrival>
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
    ...mapGetters(['getAllStops', 'getCurrentStop', 'getNorthboundArrivals', 'getSouthboundArrivals'])
  },
  methods: {
    ...mapActions(['fetchArrivalsFromApi']),
    refreshArrivals() {
      this.$store.dispatch('fetchArrivalsFromApi', this.$store.state.currentStop)
    }
  },
  mounted() {
    if (this.$store.state.allStops.length < 1) {
      this.$store.dispatch('fetchAllStopsFromApi')
      this.refreshArrivals()
    }    
    this.timer = setInterval(() => { this.refreshArrivals() }, 30000)
  },
  beforeDestroy() {
    clearInterval(this.timer)
  }
}
</script>
