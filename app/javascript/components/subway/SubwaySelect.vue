<template>
  <div class="select is-rounded is-large is-fullwidth">
    <select @change="fetchSubwayArrivalsFromApi($event.target.value)">
      <option value="">---</option>
      <option v-for="(stop, index) in getAllSubwayStops"
        :value="stop[0]"
        :key="index"
        :selected="stop[0] == getCurrentSubwayStop">
          {{`${stop[1]} - ${stop[2]}`}}
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
