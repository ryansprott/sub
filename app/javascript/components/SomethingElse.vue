<template>
  <div>    
    <div>
      {{getFirstName}} {{getLastName}}
    </div>
    <div>
      <select @change="setName({ 
        type: 'first', 
        name: $event.target.value 
      })">
        <option value="">---</option>
        <option value="foo">Foo</option>
        <option value="bar">Bar</option>
      </select>
    </div>
    <div>
      <input @input="setName({ 
        type: 'last', 
        name: $event.target.value 
      })" />
    </div>
    <div>
      {{getUpperCase}}
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
