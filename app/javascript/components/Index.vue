<template>
  <div class="app-category">
    <div v-for="post in posts" v-bind:key="post.id">
      <app-post :link="post.rest_api_enabler.Link">
        <h3 slot="title" v-html="post.title.rendered"></h3>
        <span slot="content" v-html="post.excerpt.rendered"></span>
      </app-post>
    </div>
  </div>
</template>

<script>
import Post from './Post.vue'
import appService from '../appService'
export default {
  components: {
    'app-post': Post
  },
  data () {
    return {      
      posts: []
    }
  },
  methods: {
    loadPosts () {
      appService.getPosts('2').then(data => {
        this.posts = data
      })
    }    
  },
  created () {
    this.loadPosts()
  }  
}
</script>
