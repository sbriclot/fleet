function outputValue() {
  const inputSlider = document.querySelector("#refuel-number");
  const titleSpan = document.querySelector("#title-number");
  const outputElement = document.querySelector("#number");
  if (inputSlider) {
    // Need to select the datasets and select the last n elements depending on the slider value
    inputSlider.addEventListener("input", () => {
      outputElement.value = inputSlider.value;
      titleSpan.textContent = inputSlider.value;
    });
  }
}

export { outputValue };
