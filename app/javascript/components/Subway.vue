<template>
  <div>    
    <div class="select is-rounded is-large is-fullwidth">
      <select :value="getCurrentStop" @change="fetchArrivalsFromApi($event.target.value)">
        <option v-for="(stop, index) in getAllStops" :value="stop[1]" v-bind:key="index">
          {{stop[2] + ' - ' + stop[3]}}
        </option>
      </select>
    </div>
    <hr />
    <h1 class="title is-3">Northbound</h1>
    <div v-for="(stop, index) in getNorthboundArrivals" v-bind:key="index">
      <h2 class="title is-5">{{index}}</h2>
      {{stop}}
    </div>
    <hr />
    <h1 class="title is-3">Southbound</h1>
    <div v-for="(stop, index) in getSouthboundArrivals" v-bind:key="index">
      <h2 class="title is-5">{{index}}</h2>
      {{stop}}
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters(['getAllStops', 'getCurrentStop', 'getNorthboundArrivals', 'getSouthboundArrivals'])
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
