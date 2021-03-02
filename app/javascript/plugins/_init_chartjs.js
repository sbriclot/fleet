import Chart from "chart.js";

const ctx = document.querySelector("#refuels-charts").getContext("2d");
const refuelChart = new Chart(ctx, {
  type: "line",
  data: {
    labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
    datasets: [
      {
        label: "Prix du plein",
        data: [12, 19, 3, 5, 2, 3],
        backgroundColor: ["rgba(90,192,77, 1)"],
        borderColor: ["rgba(30,111,20, 1)"],
        borderWidth: 1,
      },
      {
        label: "Quantité de carburant",
        data: [55, 12, 36, 95, 45, 58],
        backgroundColor: ["rgba(169,169,245, 1)"],
        borderColor: ["rgba(49,4,180, 1)"],
        borderWidth: 1,
      },
    ],
  },
  options: {
    scales: {
      yAxes: [
        {
          ticks: {
            beginAtZero: true,
          },
        },
      ],
    },
  },
});

export { refuelChart };
