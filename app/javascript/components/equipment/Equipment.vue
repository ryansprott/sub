<template>
  <div>
    <div v-for="(item, ndx) in getEquipmentStatus" :key="ndx" class="content">
      <h1>{{boroughHelper(ndx)}}</h1>
      <div v-for="(status, i) in item" :key="i">
        <div class="card">
          <header class="card-header">
            <p class="card-header-title">{{status.station}}</p>
          </header>
          <div class="card-content">
            <div class="content">
              <p>{{status.serving}}</p>
              <p>From {{status.outage_start}} to {{status.outage_end}}</p>
            </div>
          </div>
          <footer class="card-footer">
            <div class="card-footer-item">
              <span v-for="(train, n) in status.trains" :key="n" :class="'bullet train-' + train">
                {{train}}
              </span>
            </div>
            <div class="card-footer-item">{{status.reason}}</div>
          </footer>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
export default {
  data() {
    return {
      timer: ''
    }
  },
  computed: {
    ...mapGetters(['getEquipmentStatus'])
  },
  methods: {
    refreshEquipmentStatus() {
      this.$store.dispatch('fetchEquipmentStatusFromApi')
    },
    boroughHelper(abbrev) {
      if (abbrev === "MN") {
        return "Manhattan"
      } else if (abbrev === "BX") {
        return "The Bronx"
      } else if (abbrev === "QNS") {
        return "Queens"
      } else if (abbrev === "BKN") {
        return "Brooklyn"
      } else {
        return "Dunno"
      }
    }
  },
  mounted() {
    this.refreshEquipmentStatus()
    this.timer = setInterval(() => { this.refreshEquipmentStatus() }, 30000)
  },
  beforeDestroy() {
    clearInterval(this.timer)
  }
}
</script>

<style lang="scss">
  .bullet {
    color: white;
    border-radius: 6em;
    min-width: 1.5em;
    text-align: center;
    font-weight: bolder;
    margin-right: 0.15em;
  }

  .train-1, .train-2, .train-3 {
    background: red;
  }

  .train-4, .train-5, .train-6 {
    background: green;
  }

  .train-7 {
    background: purple;
  }

  .train-A, .train-C, .train-E {
    background: blue;
  }

  .train-B, .train-D, .train-F, .train-M {
    background: orange;
  }

  .train-N, .train-Q, .train-R, .train-W {
    background: yellow;
  }

  .train-G {
    background: lightgreen;
  }

  .train-J, .train-Z {
    background: brown;
  }

</style>
