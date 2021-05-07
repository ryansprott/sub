<template>
  <div>
    <subway-select></subway-select>
    <hr />
    <div class="columns">
      <div class="column">
        <subway-arrival
          :arrivals="getNorthboundSubwayArrivals"
          direction="Northbound"
        >
        </subway-arrival>
      </div>
      <div class="column">
        <subway-arrival
          :arrivals="getSouthboundSubwayArrivals"
          direction="Southbound"
        >
        </subway-arrival>
      </div>
    </div>
  </div>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import SubwayArrival from "./SubwayArrival.vue";
import SubwaySelect from "./SubwaySelect.vue";
export default {
  data() {
    return {
      timer: "",
    };
  },
  components: {
    "subway-arrival": SubwayArrival,
    "subway-select": SubwaySelect,
  },
  computed: {
    ...mapGetters([
      "getNorthboundSubwayArrivals",
      "getSouthboundSubwayArrivals",
    ]),
  },
  methods: {
    populateSubwayStops() {
      this.$store.dispatch("fetchAllSubwayStopsFromApi");
    },
    refreshSubwayArrivals() {
      this.$store.dispatch(
        "fetchSubwayArrivalsFromApi",
        this.$store.state.currentSubwayStop
      );
    },
  },
  mounted() {
    if (this.$store.state.allSubwayStops.length < 1) {
      this.populateSubwayStops();
    }
    this.refreshSubwayArrivals();
    this.timer = setInterval(() => {
      this.refreshSubwayArrivals();
    }, 30000);
  },
  beforeDestroy() {
    clearInterval(this.timer);
  },
};
</script>
