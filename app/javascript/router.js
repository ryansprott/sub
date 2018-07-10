import Vue from 'vue'
import VueRouter from 'vue-router'
import Category from './Category.vue'

Vue.use(VueRouter)

const router = new VueRouter({
  routes: [{
    path: '/', component: Category
  }]
})

export default router
