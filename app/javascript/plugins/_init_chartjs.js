import Chart from "chart.js";
const ctx = document.querySelector("#refuels-charts").getContext("2d");
const refuelChart = new Chart(ctx, {
  type: line,
});

export { refuelChart };
