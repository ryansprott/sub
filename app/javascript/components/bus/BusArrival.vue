<template>
  <table class="table is-fullwidth">
    <thead>
      <tr>
        <th>Line</th>
        <th>Destination</th>
        <th>Distance</th>
        <th>Stops Away</th>
        <th>Expected Arrival</th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="(arrival, index) in arrivals" :key="index">
        <td>
          <b>{{ arrival.published_line_name }}</b>
        </td>
        <td>{{ arrival.destination_name }}</td>
        <td>{{ arrival.presentable_distance }}</td>
        <td>{{ arrival.stops_from_call }}</td>
        <td>{{ formatDate(arrival.expected_arrival_time) }}</td>
      </tr>
    </tbody>
  </table>
</template>

<script>
export default {
  props: ["arrivals"],
  methods: {
    formatDate(str) {
      var newDate = new Date(str);
      return newDate == "Invalid Date" ? "" : newDate.toLocaleTimeString();
    },
  },
};
</script>
