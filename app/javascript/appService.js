import axios from 'axios'
import NProgress from 'nprogress'

//axios.defaults.baseURL = "https://api.fullstackweekly.com"

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
  getAllStops () {
    return new Promise((resolve) => {
      axios.get('http://localhost:3000/all_stops')
      .then(response => {
        resolve(response.data)
      })  
    })    
  },
  getArrivals (stopId) {
    return new Promise((resolve) => {
      axios.get('http://localhost:3000/stop_info/' + stopId)
      .then(response => {
        resolve(response.data)
      })  
    })    
  }
}

export default appService
