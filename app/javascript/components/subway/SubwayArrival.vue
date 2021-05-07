<template>
  <div>
    <h1 class="title is-3">
      {{ direction }}
    </h1>
    <div v-for="(arrival, index) in arrivals" :key="index">
      <h2 :class="'title is-5 box bullet train-' + index">
        {{ index }}
      </h2>
      <ul>
        <li v-for="(element, ndx) in arrival" :key="ndx">
          {{ element }}
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  props: ["arrivals", "direction"],
};
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

.train-1,
.train-2,
.train-3 {
  background: #ee352e;
  color: white;
}

.train-4,
.train-5,
.train-6 {
  background: #00933c;
  color: white;
}

.train-7 {
  background: #b933ad;
  color: white;
}

.train-A,
.train-C,
.train-E {
  background: #0039a6;
  color: white;
}

.train-B,
.train-D,
.train-F,
.train-M {
  background: #ff6319;
  color: white;
}

.train-L {
  background: #a7a9ac;
  color: white;
}

.train-N,
.train-Q,
.train-R,
.train-W {
  background: #fccc0a;
  color: black;
}

.train-G {
  background: #6cbe45;
  color: white;
}

.train-S {
  background: #808183;
  color: white;
}

.train-J,
.train-Z {
  background: #996633;
  color: white;
}
</style>
