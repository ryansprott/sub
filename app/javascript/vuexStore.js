import Vue from 'vue'
import Vuex from 'vuex'
import appService from './appService'
Vue.use(Vuex)

const state = {
  user: {
    firstname: 'place',
    lastname: 'holder'
  },
  optionSelected: '',
  apiCategories: ['1', '2', '3', '4', '5', '6', '11'],
  postsToShow: [],
  allStops: [],
  currentStop: 'R01',
  arrivals: {}
}

const store = new Vuex.Store({
  state,
  getters: {
    getFirstName() {
      return state.user.firstname
    },
    getLastName() {
      return state.user.lastname
    },
    getUpperCase () {
      return state.user.firstname.toUpperCase() 
        + ' ' 
        + state.user.lastname.toUpperCase()
    },
    getPostsToShow () {
      return state.postsToShow
    },
    getOptionSelected () {
      return state.optionSelected
    },
    getApiCategories () {
      return state.apiCategories
    },
    getAllStops () {
      return state.allStops
    },
    getNorthboundArrivals() {
      return state.arrivals.NB
    },
    getSouthboundArrivals() {
      return state.arrivals.SB
    },
    getCurrentStop () {
      return state.currentStop
    }
  },
  mutations: {
    setFirstName (state, payload) {
      state.user.firstname = payload
    },
    setLastName (state, payload) {
      state.user.lastname = payload
    },
    updatePosts (state, payload) {
      state.postsToShow = payload
    },
    updateOptionSelected (state, payload) {
      state.optionSelected = payload
    },
    updateStops (state, payload) {
      state.allStops = payload
    },
    updateArrivals (state, payload) {
      state.arrivals = payload
    },
    updateCurrentStop (state, payload) {
      state.currentStop = payload
    }
  },
  actions: {
    setName (context, payload) {
      if (payload.name) {
        if (payload.type == 'first') {
          context.commit('setFirstName', payload.name)
        } else if (payload.type == 'last') {
          context.commit('setLastName', payload.name)
        }
      }
    },
    fetchPostsFromApi (context, payload) {
      if (payload) {
        appService.getPosts(payload).then(data => {
          context.commit('updatePosts', data)
        })
        context.commit('updateOptionSelected', payload)  
      }
    },
    fetchAllStopsFromApi (context, payload) {
      appService.getAllStops().then(data => {
        context.commit('updateStops', data)
      })
    },
    fetchArrivalsFromApi(context, payload) {
      if (payload) {
        appService.getArrivals(payload).then(data => {
          context.commit('updateArrivals', data)
        })
        context.commit('updateCurrentStop', payload)  
      }
    }
  }
})

export default store
