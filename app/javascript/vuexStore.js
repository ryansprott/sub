import Vue from 'vue'
import Vuex from 'vuex'
import appService from './appService'
Vue.use(Vuex)

const state = {
  equipmentStatus: [],
  userInputSubway: 'IND 63rd St Line - 21 St - Queensbridge',
  allSubwayStops: [],
  currentSubwayStop: 'B04',
  subwayArrivals: {},
  userInputBus: '550685 - 21 ST/BROADWAY - SW',
  allBusStops: [],
  currentBusStop: '550685',
  busArrivals: {}
}

const store = new Vuex.Store({
  state,
  getters: {
    getEquipmentStatus () {
      return state.equipmentStatus
    },
    getAllSubwayStops () {
      return state.allSubwayStops
    },
    getNorthboundSubwayArrivals() {
      return state.subwayArrivals.NB
    },
    getSouthboundSubwayArrivals() {
      return state.subwayArrivals.SB
    },
    getCurrentSubwayStop () {
      return state.currentSubwayStop
    },
    getAllBusStops () {
      return state.allBusStops
    },
    getBusArrivals() {
      return state.busArrivals
    },
    getCurrentBusStop () {
      return state.currentBusStop
    }
  },
  mutations: {
    updateEquipmentStatus (state, payload) {
      state.equipmentStatus = payload
    },
    updateSubwayStops (state, payload) {
      state.allSubwayStops = payload
    },
    updateSubwayArrivals (state, payload) {
      state.subwayArrivals = payload
    },
    updateCurrentSubwayStop (state, payload) {
      state.currentSubwayStop = payload
    },
    updateBusStops (state, payload) {
      state.allBusStops = payload
    },
    updateBusArrivals (state, payload) {
      state.busArrivals = payload
    },
    updateCurrentBusStop (state, payload) {
      state.currentBusStop = payload
    }
  },
  actions: {
    fetchEquipmentStatusFromApi (context, payload) {
      appService.getEquipmentStatus().then(data => {
        context.commit('updateEquipmentStatus', data)
      })
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
    },
    fetchAllBusStopsFromApi (context, payload) {
      appService.getAllBusStops().then(data => {
        context.commit('updateBusStops', data)
      })
    },
    fetchBusArrivalsFromApi(context, payload) {
      if (payload) {
        appService.getBusArrivals(payload).then(data => {
          context.commit('updateBusArrivals', data)
        })
        context.commit('updateCurrentBusStop', payload)
      }
    }
  }
})

export default store
