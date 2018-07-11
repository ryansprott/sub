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
  postsToShow: []
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
    getPostsFromApi (context, payload) {
      appService.getPosts(payload).then(data => {
        context.commit('updatePosts', data)
      })
      context.commit('updateOptionSelected', payload)
    }
  }
})

export default store
