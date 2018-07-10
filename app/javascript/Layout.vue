<template>
  <div id="layout">
    <p>{{ message }}</p>
  </div>
</template>

<script>
export default {
  data () {
    return {
      items: [
        {id: 1, content: "Foo"},
        {id: 2, content: "Bar"},
        {id: 3, content: "Baz"}
      ],
      message: "Hello Vue."
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
