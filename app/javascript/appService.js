import axios from 'axios'
import NProgress from 'nprogress'

axios.interceptors.request.use(config => {
  NProgress.start()
  return config
})

axios.interceptors.response.use(response => {
  NProgress.done()
  return response
})

const appService = {
  getEquipmentStatus () {
    return doAjax('/equipment_status')
  },
  getServiceStatus () {
    return doAjax('/service_status')
  },
  getAllSubwayStops () {
    return doAjax('/all_subway_stops')
  },
  getSubwayArrivals (stopId) {
    return doAjax('/subway_arrivals/', stopId)
  },
  getAllBusStops () {
    return doAjax('/all_bus_stops')
  },
  getBusArrivals (stopId) {
    return doAjax('/bus_arrivals/', stopId)
  }
}

const doAjax = (url, param = '') => {
  return new Promise((resolve) => {
    axios.get(url + param)
    .then(response => {
      resolve(response.data)
    }).catch(err => {
      console.error(err)
    })
  })
}

export default appService
