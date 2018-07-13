<template>
  <div class="columns">
    <div class="column">
      <div class="select is-rounded is-large is-fullwidth">
        <select :value="getCurrentBusStop" @change="fetchBusArrivalsFromApi($event.target.value)">
          <option value="">---</option>
          <option v-for="stop in getAllBusStops" :value="stop[1]" v-bind:key="stop[0]">
            {{stop[1] + ' - ' + stop[3] + ' - ' + stop[4]}}
          </option>
        </select>
      </div>
      <!--
      <div class="column" v-for="post in getPostsToShow" v-bind:key="post.id">
        <app-post :link="post.rest_api_enabler.Link">
          <h3 class="title is-4" slot="title" v-html="post.title.rendered"></h3>
          <span slot="content" v-html="post.excerpt.rendered"></span>
        </app-post>
      </div>
      -->
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import Post from './Post.vue'
export default {
  data() {
    return {
      timer: ''
    }
  },
  components: {
    'app-post': Post
  },
  methods: {
    ...mapActions(['fetchBusArrivalsFromApi']),
    populateBusStops() {
      this.$store.dispatch('fetchAllBusStopsFromApi')
    },
    refreshBusArrivals() {
      this.$store.dispatch('fetchBusArrivalsFromApi', this.$store.state.currentBusStop)
    }
  },
  computed: {
    ...mapGetters(['getAllBusStops', 'getCurrentBusStop', 'getBusArrivals'])
  },
  mounted() {
    if (this.$store.state.allBusStops.length < 1) {
      this.populateBusStops()
      this.refreshBusArrivals()
    }
    this.timer = setInterval(() => { this.refreshBusArrivals() }, 30000)
  },
  beforeDestroy() {
    clearInterval(this.timer)
  }
}
</script>
