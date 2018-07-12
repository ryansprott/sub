<template>
  <div>    
    <div class="select is-rounded is-large is-fullwidth">
      <select :value="getCurrentStop" @change="fetchArrivalsFromApi($event.target.value)">
        <option v-for="(stop, index) in getAllStops" :value="stop[1]" v-bind:key="index">
          {{stop[2] + ' - ' + stop[3]}}
        </option>
      </select>
    </div>
    <subway-arrival :arrivals="getNorthboundArrivals" direction="Northbound"></subway-arrival>
    <subway-arrival :arrivals="getSouthboundArrivals" direction="Southbound"></subway-arrival>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import SubwayArrival from './SubwayArrival.vue'
export default {
  components: {
    'subway-arrival': SubwayArrival
  },
  computed: {
    ...mapGetters(['getAllStops', 'getCurrentStop', 'getNorthboundArrivals', 'getSouthboundArrivals'])
  },
  methods: {
    ...mapActions(['fetchArrivalsFromApi'])
  },
  mounted() {
    if (this.$store.state.allStops.length < 1) {
      this.$store.dispatch('fetchAllStopsFromApi')
      this.$store.dispatch('fetchArrivalsFromApi', this.$store.state.currentStop)
    }    
  }
}
</script>
