<template>
  <div class="select is-rounded is-large is-fullwidth">
    <select :value="getCurrentSubwayStop" @change="fetchSubwayArrivalsFromApi($event.target.value)">
      <option value="">---</option>
      <option v-for="(stop, index) in getAllSubwayStops" :value="stop[1]" :key="index">
        {{stop[2] + ' - ' + stop[3]}}
      </option>
    </select>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters(['getAllSubwayStops', 'getCurrentSubwayStop'])
  },
  methods: {
    ...mapActions(['fetchSubwayArrivalsFromApi'])
  }
}
</script>
