import Vue from 'vue'
import Vuex from 'vuex'
import appService from './appService'
Vue.use(Vuex)

const state = {
  optionSelected: '',
  apiCategories: ['1', '2', '3', '4', '5', '6', '11'],
  postsToShow: [],
  allSubwayStops: [],
  currentStop: 'B04',
  arrivals: {}
}

const store = new Vuex.Store({
  state,
  getters: {
    getPostsToShow () {
      return state.postsToShow
    },
    getOptionSelected () {
      return state.optionSelected
    },
    getApiCategories () {
      return state.apiCategories
    },
    getAllSubwayStops () {
      return state.allSubwayStops
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
    updatePosts (state, payload) {
      state.postsToShow = payload
    },
    updateOptionSelected (state, payload) {
      state.optionSelected = payload
    },
    updateStops (state, payload) {
      state.allSubwayStops = payload
    },
    updateArrivals (state, payload) {
      state.arrivals = payload
    },
    updateCurrentStop (state, payload) {
      state.currentStop = payload
    }
  },
  actions: {
    fetchPostsFromApi (context, payload) {
      if (payload) {
        appService.getPosts(payload).then(data => {
          context.commit('updatePosts', data)
        })
        context.commit('updateOptionSelected', payload)  
      }
    },
    fetchAllSubwayStopsFromApi (context, payload) {
      appService.getAllSubwayStops().then(data => {
        context.commit('updateStops', data)
      })
    },
    fetchArrivalsFromApi(context, payload) {
      if (payload) {
        appService.getSubwayArrivals(payload).then(data => {
          context.commit('updateArrivals', data)
        })
        context.commit('updateCurrentStop', payload)  
      }
    }
  }
})

export default store
