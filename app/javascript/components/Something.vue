<template>
  <div>
    <h3>Something</h3>
    <something-else></something-else>
  </div>
</template>

<script>
import SomethingElse from './SomethingElse.vue'
export default {
  components: {
    'something-else': SomethingElse
  }
}
</script>
