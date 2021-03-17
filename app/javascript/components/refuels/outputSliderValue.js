function outputValue() {
  const inputSlider = document.querySelector("#refuel-number");
  const titleSpan = document.querySelector("#title-number");
  const outputElement = document.querySelector("#number");
  if (inputSlider) {
    //window.addEventListener("load", updateValue);
    inputSlider.addEventListener("input", () => {
      outputElement.value = inputSlider.value;
      titleSpan.textContent = inputSlider.value;
    });
  }
}

export { outputValue };
