<template>
  <div>    
    <div class="select is-rounded is-large is-fullwidth">
      <select :value="getCurrentStop" @change="fetchArrivalsFromApi($event.target.value)">
        <option v-for="stop in getAllStops" :value="stop[1]" v-bind:key="stop[0]">
          {{stop[2] + ' - ' + stop[3]}}
        </option>
      </select>
    </div>
    <h1>Northbound</h1>
    <div v-for="stop in getNorthboundStops" v-bind:key="stop[3]">
      {{stop}}
    </div>
    <h1>Southbound</h1>
    <div v-for="stop in getSouthboundStops" v-bind:key="stop[3]">
      {{stop}}
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters(['getAllStops', 'getNorthboundStops', 'getSouthboundStops', 'getCurrentStop'])
  },
  methods: {
    ...mapActions(['fetchArrivalsFromApi'])
  },
  mounted() {
    if (this.$store.state.allStops.length < 1) {
      this.$store.dispatch('fetchAllStopsFromApi')
    }    
  }
}
</script>
