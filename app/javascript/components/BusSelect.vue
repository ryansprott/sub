<template>
  <div class="select is-rounded is-large is-fullwidth" v-cloak>
    <select @change="fetchBusArrivalsFromApi($event.target.value)">
      <option value="">---</option>
      <option v-for="stop in getAllBusStops"
        :value="stop[1]"
        :key="stop[0]"
        :selected="stop[1] == getCurrentBusStop">
          {{`${stop[1]} - ${stop[3]} - ${stop[4]}`}}
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
