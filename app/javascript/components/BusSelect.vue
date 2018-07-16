<template>
  <div class="select is-rounded is-large is-fullwidth" v-cloak>
    <select :value="getCurrentBusStop" @change="fetchBusArrivalsFromApi($event.target.value)">
      <option value="">---</option>
      <option v-for="stop in getAllBusStops" :value="stop[1]" v-bind:key="stop[0]">
        {{stop[1] + ' - ' + stop[3] + ' - ' + stop[4]}}
      </option>
    </select>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters(['getAllBusStops', 'getCurrentBusStop'])
  },
  methods: {
    ...mapActions(['fetchBusArrivalsFromApi'])
  }
}
</script>
