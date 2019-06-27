<template>
  <b-autocomplete rounded
    v-model="userInput"
    field="label"
    size="is-large"
    :open-on-focus="true"
    :data="filterStops()"
    @select="updateCurrent($event)" />
</template>

<script>
export default {
  computed: {
    userInput: {
      get() { return this.$store.state.userInputBus },
      set(value) { this.$store.state.userInputBus = value }
    },
  },
  methods: {
    updateCurrent(e) {
      if (e && e.value) {
        this.$store.dispatch('fetchBusArrivalsFromApi', e.value)
      }
    },
    filterStops() {
      return this.$store.getters.getAllBusStops.filter(option => {
        return option.label.toLowerCase().indexOf(this.$store.state.userInputBus.toLowerCase()) >= 0
      })
    },
  },
}
</script>
