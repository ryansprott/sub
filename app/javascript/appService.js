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
  getPosts (categoryId) {
    return new Promise((resolve) => {
      axios.get(`https://api.fullstackweekly.com/wp-json/wp/v2/posts?categories=${categoryId}&per_page=6`)
      .then(response => {
        resolve(response.data)
      })  
    })
  },
  getAllSubwayStops () {
    return new Promise((resolve) => {
      axios.get('/all_subway_stops')
      .then(response => {
        resolve(response.data)
      })  
    })    
  },
  getSubwayArrivals (stopId) {
    return new Promise((resolve) => {
      axios.get('/subway_arrivals/' + stopId)
      .then(response => {
        resolve(response.data)
      })  
    })    
  }
}

export default appService
