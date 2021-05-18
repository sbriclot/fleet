import Chart from "chart.js";
const dataSlider = (chart, priceData, quantityData, datesData) => {
  const sliderInput = document.querySelector("#refuel-slider");
  if (sliderInput) {
    sliderInput.addEventListener("input", () => {
      // Filtering the data and labels based on input slider value
      const filteredQuantity = quantityData.slice(-sliderInput.value);
      const filteredPrices = priceData.slice(-sliderInput.value);
      const filteredLabels = datesData.slice(-sliderInput.value);
      // Replacing the chart data with the filtered one
      chart.data.datasets[0].data = filteredQuantity;
      chart.data.datasets[1].data = filteredPrices;
      chart.data.labels = filteredLabels;
      // Updating the chart
      chart.update();
    });
  }
};

const refuelChart = () => {
  const ctxRefuels = document.querySelector("#refuels-charts");
  if (ctxRefuels) {
    const price = JSON.parse(ctxRefuels.dataset.price);
    const quantity = JSON.parse(ctxRefuels.dataset.quantity);
    const dates = JSON.parse(ctxRefuels.dataset.dates);
    const sliderInput = document.querySelector("#refuel-slider");
    const refuelChartCanvas = new Chart(ctxRefuels, {
      type: "bar",
      data: {
        labels: dates.slice(-sliderInput.value),
        datasets: [
          {
            label: "Quantité de carburant",
            data: quantity.slice(-sliderInput.value),
            backgroundColor: "rgba(169,169,245, 1)",
            borderColor: "rgba(49,4,180, 1)",
            borderWidth: 1,
          },
          {
            label: "Prix du plein",
            data: price.slice(-sliderInput.value),
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
                ? (label += ` : ${(+tooltipItem.value).toFixed(2)} €`)
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
    dataSlider(refuelChartCanvas, price, quantity, dates);
  }
};

const averageChart = () => {
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
        scales: {
          yAxes: [
            {
              ticks: {
                beginAtZero: true,
              },
            },
          ],
        },
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
