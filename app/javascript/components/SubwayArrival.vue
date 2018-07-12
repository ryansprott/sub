<template>
  <div>
    <hr />    
    <h1 class="title is-3">{{direction}}</h1>
    <div v-for="(arrival, index) in arrivals" v-bind:key="index">
      <hr />
      <h2 class="title is-5">{{index}}</h2>
      <ul>
        <li v-for="(element, ndx) in arrival" v-bind:key="ndx">
          {{element}}
        </li>      
      </ul>      
    </div>    
  </div>
</template>

<script>
export default {
  props: ['arrivals', 'direction']  
}
</script>
