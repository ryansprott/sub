<template>
  <div>
    <h1 class="title is-3">
      {{direction}}
    </h1>
    <div v-for="(arrival, index) in arrivals" :key="index">
      <h2 :class="'title is-5 box bullet train-' + index">
        {{index}}
      </h2>
      <ul>
        <li v-for="(element, ndx) in arrival" :key="ndx">
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

<style scoped>
  ul {
    padding-bottom: 20px;
    min-height: 100px;
  }

  .bullet {
    border-radius: 6em;
    min-width: 1.5em;
    text-align: center;
    font-weight: bolder;
    margin-right: 0.15em;
  }

  .train-1, .train-2, .train-3 {
    background: #EE352E;
    color: white;
  }

  .train-4, .train-5, .train-6 {
    background: #00933C;
    color: white;
  }

  .train-7 {
    background: #B933AD;
    color: white;
  }

  .train-A, .train-C, .train-E {
    background: #0039A6;
    color: white;
  }

  .train-B, .train-D, .train-F, .train-M {
    background: #FF6319;
    color: white;
  }

  .train-L {
    background: #A7A9AC;
    color: white;
  }

  .train-N, .train-Q, .train-R, .train-W {
    background: #FCCC0A;
    color: black;
  }

  .train-G {
    background: #6CBE45;
    color: white;
  }

  .train-S {
    background: #808183;
    color: white;
  }

  .train-J, .train-Z {
    background: #996633;
    color: white;
  }
</style>
