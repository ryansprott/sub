import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const state = {
  currentStop: 'R01'
}

const store = new Vuex.Store({
  state,
  getters: {
    getStop: () => {
      return state.currentStop
    }
  },
  mutations: {
    setStop: (state, payload) => {
      state.currentStop = payload
    }
  },
  actions: {
    setStop: (context) => {
      context.commit('setStop')
    }
  }
})

export default store
