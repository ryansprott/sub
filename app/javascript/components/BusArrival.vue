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
      <tr v-for="arrival in arrivals" v-bind:key="arrival.id">
        <td><b>{{arrival.MonitoredVehicleJourney.PublishedLineName}}</b></td>
        <td>{{arrival.MonitoredVehicleJourney.DestinationName}}</td>
        <td>{{arrival.MonitoredVehicleJourney.MonitoredCall.Extensions.Distances.PresentableDistance}}</td>
        <td>{{arrival.MonitoredVehicleJourney.MonitoredCall.Extensions.Distances.StopsFromCall}}</td>
        <td>{{formatDate(arrival.MonitoredVehicleJourney.MonitoredCall.ExpectedArrivalTime)}}</td>
      </tr>
    </tbody>
  </table>
</template>

<script>
export default {
  props: ['arrivals'],
  methods: {
    formatDate(str) {
      var newDate = new Date(str);
      return (newDate == 'Invalid Date') ? '' : newDate.toLocaleTimeString();
    }
  }
}
</script>
