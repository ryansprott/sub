<template>
  <nav class="nav has-shadow">
    <div class="container">
      <div class="tabs is-fullwidth is-toggle is-boxed">
        <ul>
          <li>
            <router-link class="nav-item is-tab" to="/index" exact>
              Bus
            </router-link>
          </li>
          <li>
            <router-link class="nav-item is-tab" to="/subway" exact>
              Subway
            </router-link>
          </li>
          <li>
            <router-link class="nav-item is-tab" to="/equipment" exact>
              Equipment
            </router-link>
          </li>
          <li>
            <router-link class="nav-item is-tab" to="/service" exact>
              Service
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
