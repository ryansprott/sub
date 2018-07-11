<template>
  <div class="columns">
    <div class="column">
      <div class="select is-rounded is-large is-fullwidth">
        <select :value="getOptionSelected" @change="fetchPostsFromApi($event.target.value)">
          <option value="">---</option>
          <option v-for="cat in getApiCategories" :value="cat" v-bind:key="cat">
            Category {{cat}}
          </option>
        </select>
      </div>
      <div class="column" v-for="post in getPostsToShow" v-bind:key="post.id">
        <app-post :link="post.rest_api_enabler.Link">
          <h3 slot="title" v-html="post.title.rendered"></h3>
          <span slot="content" v-html="post.excerpt.rendered"></span>
        </app-post>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import Post from './Post.vue'
export default {
  components: {
    'app-post': Post
  },
  methods: {
    ...mapActions(['fetchPostsFromApi'])
  },
  computed: {
    ...mapGetters(['getPostsToShow', 'getOptionSelected', 'getApiCategories'])
  }
}
</script>
