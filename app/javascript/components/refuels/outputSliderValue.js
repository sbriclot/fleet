function outputValue() {
  const inputSlider = document.querySelector("#refuel-slider");
  const titleSpan = document.querySelector("#title-number");
  const outputElement = document.querySelector("#slider-value");
  if (inputSlider) {
    // Need to select the datasets and select the last n elements depending on the slider value
    inputSlider.addEventListener("input", () => {
      outputElement.value = inputSlider.value;
      titleSpan.textContent = inputSlider.value;
    });
  }
}

export { outputValue };
