import axios from 'axios'
//import { resolve } from 'path';

axios.defaults.baseURL = "https://api.fullstackweekly.com"

axios.interceptors.request.use(config => {
  console.log("AJAX start")
  return config
})

axios.interceptors.response.use(response => {
  console.log("AJAX stop")
  return response
})

const appService = {
  getPosts (categoryId) {
    return new Promise((resolve) => {
      axios.get(`/wp-json/wp/v2/posts?categories=${categoryId}&per_page=6`)
      .then(response => {
        resolve(response.data)
      })  
    })
  }
}

export default appService
