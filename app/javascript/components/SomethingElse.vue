<template>
    <div>
      <select :value="getOptionSelected" @change="getPostsFromApi($event.target.value)">
        <option value="">---</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
        <option value="11">11</option>
      </select>
      <div v-for="post in getPostsToShow" v-bind:key="post.id">
        <app-post :link="post.rest_api_enabler.Link">
          <h3 slot="title" v-html="post.title.rendered"></h3>
          <span slot="content" v-html="post.excerpt.rendered"></span>
        </app-post>
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
    ...mapActions(['getPostsFromApi'])
  },
  computed: {
    ...mapGetters(['getPostsToShow', 'getOptionSelected'])
  }
}
</script>
