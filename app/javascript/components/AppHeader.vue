<template>
  <nav class="nav has-shadow">
    <div class="container">
      <div class="tabs is-fullwidth">
        <ul>
          <li>
            <router-link class="nav-item is-tab" to="/" exact>
              Name
            </router-link>
          </li>
          <li>
            <router-link class="nav-item is-tab" to="/something" exact>
              Posts
            </router-link>
          </li>
          <li>
            <router-link class="nav-item is-tab" to="/stops" exact>
              Stops
            </router-link>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<style scoped>
div.tabs {
  padding-bottom: 20px;
}
</style>
