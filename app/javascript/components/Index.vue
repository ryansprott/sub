<template>
  <div>
    <div>{{getFirstName}} {{getLastName}} ({{getUpperCase}})</div>    
    <div>
      <input @input="setName({
        type: 'first',
        name: $event.target.value
      })" />

      <input @input="setName({
        type: 'last',
        name: $event.target.value
      })" />
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
  methods: {
    ...mapActions(['setName'])
  },
  computed: {
    ...mapGetters(['getFirstName', 'getLastName', 'getUpperCase'])
  } 
}
</script>
