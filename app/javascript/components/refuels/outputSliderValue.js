function outputValue() {
  const inputSlider = document.querySelector("#refuel-slider");
  const titleSpan = document.querySelector("#title-number");
  const outputElement = document.querySelector(".refuel-slider__value");
  const updateValue = () => {
    outputElement.textContent = inputSlider.value;
    titleSpan.textContent = inputSlider.value;
  };
  if (inputSlider) {
    inputSlider.addEventListener("load", updateValue);
    inputSlider.addEventListener("input", updateValue);
  }
}

export { outputValue };
