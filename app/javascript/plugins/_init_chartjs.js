import Chart from "chart.js";

const refuelChart = () => {
  const ctxRefuels = document.querySelector("#refuels-charts");
  if (ctxRefuels) {
    const price = JSON.parse(ctxRefuels.dataset.price);
    const quantity = JSON.parse(ctxRefuels.dataset.quantity);
    const dates = JSON.parse(ctxRefuels.dataset.dates);

    new Chart(ctxRefuels, {
      type: "bar",
      data: {
        labels: dates,
        datasets: [
          {
            label: "Quantité de carburant",
            data: quantity,
            backgroundColor: "rgba(169,169,245, 1)",
            borderColor: "rgba(49,4,180, 1)",
            borderWidth: 1,
          },
          {
            label: "Prix du plein",
            data: price,
            backgroundColor: "rgba(90,192,77, 0.5)",
            borderColor: "rgba(30,111,20, 1)",
            borderWidth: 1,
          },
        ],
      },
      options: {
        scales: {
          yAxes: [
            {
              staked: true,
              ticks: {
                beginAtZero: true,
              },
            },
          ],
          xAxes: [
            {
              stacked: true,
            },
          ],
        },
      },
    });
  }
};

const averageChart = () => {
  const ctxAverage = document.querySelector("#average-chart");
  if (ctxAverage) {
    new Chart(ctxAverage, {
      type: "line",
    });
  }
};

export { refuelChart, averageChart };
