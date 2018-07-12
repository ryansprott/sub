import Vue from 'vue'
import Vuex from 'vuex'
import appService from './appService'
Vue.use(Vuex)

const state = {
  optionSelected: '',
  apiCategories: ['1', '2', '3', '4', '5', '6', '11'],
  postsToShow: [],
  allSubwayStops: [],
  currentSubwayStop: 'B04',
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
    getNorthboundSubwayArrivals() {
      return state.arrivals.NB
    },
    getSouthboundSubwayArrivals() {
      return state.arrivals.SB
    },
    getCurrentSubwayStop () {
      return state.currentSubwayStop
    }
  },
  mutations: {
    updatePosts (state, payload) {
      state.postsToShow = payload
    },
    updateOptionSelected (state, payload) {
      state.optionSelected = payload
    },
    updateSubwayStops (state, payload) {
      state.allSubwayStops = payload
    },
    updateSubwayArrivals (state, payload) {
      state.arrivals = payload
    },
    updateCurrentSubwayStop (state, payload) {
      state.currentSubwayStop = payload
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
        context.commit('updateSubwayStops', data)
      })
    },
    fetchSubwayArrivalsFromApi(context, payload) {
      if (payload) {
        appService.getSubwayArrivals(payload).then(data => {
          context.commit('updateSubwayArrivals', data)
        })
        context.commit('updateCurrentSubwayStop', payload)  
      }
    }
  }
})

export default store
