import Chart from "chart.js";
let sliderValue = 10;
const removeData = (chart) => {
  const sliderInput = document.querySelector("#refuel-slider");
  console.log(sliderInput.value);
  const step = sliderInput.step;
  if (sliderInput) {
    sliderInput.addEventListener("input", () => {
      // Not working correctly, removes element when not supposed to.
      // Maybe check the size of the dataset
      if (sliderInput.value < sliderValue) {
        chart.data.labels.splice(-sliderInput.value, step);
        chart.data.datasets.forEach((dataset) => {
          dataset.data.splice(-sliderInput.value, step);
        });
        sliderValue = sliderInput.value;
        chart.update();
      }
    });
  }
};

const refuelChart = () => {
  const ctxRefuels = document.querySelector("#refuels-charts");
  if (ctxRefuels) {
    const price = JSON.parse(ctxRefuels.dataset.price);
    const quantity = JSON.parse(ctxRefuels.dataset.quantity);
    const dates = JSON.parse(ctxRefuels.dataset.dates);
    let refuelChartCanvas = new Chart(ctxRefuels, {
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
        tooltips: {
          callbacks: {
            label: function (tooltipItem, data) {
              let label = data.datasets[tooltipItem.datasetIndex].label || "";
              let dataset = tooltipItem.datasetIndex;

              label && dataset === 1
                ? (label += ` : ${tooltipItem.value} €`)
                : (label += ` : ${tooltipItem.value} litres`);
              return label;
            },
          },
        },
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
    removeData(refuelChartCanvas);
  }
};

const averageChart = () => {
  // Need to add some breathing space for data by changing axis base values
  const ctxAverage = document.querySelector("#average-charts");
  if (ctxAverage) {
    const average = JSON.parse(ctxAverage.dataset.average);
    const dates = JSON.parse(ctxAverage.dataset.months);
    new Chart(ctxAverage, {
      type: "bar",
      data: {
        labels: dates,
        datasets: [
          {
            label: "Dépense mensuelle moyenne",
            data: average,
            backgroundColor: "rgba(90,192,77, 0.5)",
            borderColor: "rgba(30,111,20, 1)",
            borderWidth: 1,
          },
        ],
      },
      options: {
        tooltips: {
          callbacks: {
            label: function (tooltipItem, data) {
              let label = data.datasets[tooltipItem.datasetIndex].label || "";
              label += ` : ${tooltipItem.value} €`;
              return label;
            },
          },
        },
      },
    });
  }
};

export { refuelChart, averageChart };
