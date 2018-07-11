import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)

const state = {
  user: {
    firstname: 'place',
    lastname: 'holder'
  }
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
    }
  },
  mutations: {
    setFirstName (state, payload) {
      state.user.firstname = payload
    },
    setLastName (state, payload) {
      state.user.lastname = payload
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
    }
  }
})

export default store
