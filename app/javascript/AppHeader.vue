<template>
  <nav class="nav has-shadow">
    <div class="container">
      <router-link to="/" exact>
        <img src="http://bit.ly/vue-img" />
      </router-link>
      <router-link class="nav-item is-tab" to="/something" exact>
        Something
      </router-link>
    </div>
  </nav>
</template>

<style scoped>
  p {
    font-size: 2em;
    color: red;
    text-align: center;
  }
</style>
