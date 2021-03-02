import Chart from "chart.js";

const refuelChart = () => {
  const ctx = document.querySelector("#refuels-charts");
  if (ctx) {
    const price = JSON.parse(ctx.dataset.price);
    const quantity = JSON.parse(ctx.dataset.quantity);
    const dates = JSON.parse(ctx.dataset.dates)
    new Chart(ctx, {
      type: "bar",
      data: {
        labels: dates,
        datasets: [
          {
            label: "Prix du plein",
            data: price,
            backgroundColor: ["rgba(90,192,77, 0.5)"],
            borderColor: ["rgba(30,111,20, 1)"],
            borderWidth: 1,
          },
          {
            label: "Quantité de carburant",
            data: quantity,
            backgroundColor: ["rgba(169,169,245, 0.8)"],
            borderColor: ["rgba(49,4,180, 1)"],
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

export { refuelChart };
