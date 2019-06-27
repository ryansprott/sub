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
      get() { return this.$store.state.userInputSubway },
      set(value) { this.$store.state.userInputSubway = value }
    },
  },
  methods: {
    updateCurrent(e) {
      if (e && e.value) {
        this.$store.dispatch('fetchSubwayArrivalsFromApi', e.value)
      }
    },
    filterStops() {
      return this.$store.getters.getAllSubwayStops.filter(option => {
        return option.label.toLowerCase().indexOf(this.$store.state.userInputSubway.toLowerCase()) >= 0
      })
    },
  },
}
</script>
