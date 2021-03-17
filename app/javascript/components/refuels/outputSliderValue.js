const inputSlider = document.querySelector("#refuel-number");
const outputElement = document.querySelector("#number");
const titleSpan = document.querySelector("#title-number");
function outputValue() {
  if (inputSlider) {
    window.addEventListener("load", updateValue);
    inputSlider.addEventListener("input", updateValue);
  }
}

function updateValue() {
  outputElement.value = inputSlider.value;
  titleSpan.textContent = inputSlider.value;
}

export { outputValue };
