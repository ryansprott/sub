import Vue from 'vue'
import VueRouter from 'vue-router'
import Index from './components/Index.vue'
import Stops from './components/Stops.vue'
import Something from './components/Something.vue'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  linkActiveClass: 'is-active',
  routes: [
  {
    path: '/', 
    name: 'Redirect', 
    redirect: (to) => {
      if (to.query.redirect) {
        // This will clear the ?redirect=<path> from the end URL
        var path = to.query.redirect
        delete to.query.redirect
        return {
          path: '/' + path,
          query: to.query
        }
      } else {
        return {
          path: '/index',
          query: to.query
        }
      }
    }
  },
  {
    path: '/stops',
    name: 'Stops',
    component: Stops
  },
  {
    path: '/index',
    name: 'Index',
    component: Index
  },
  {
    path: '/something',
    name: 'Something',
    component: Something
  }]
})

export default router
