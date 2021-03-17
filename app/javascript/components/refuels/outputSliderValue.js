function outputValue() {
  const inputSlider = document.querySelector("#refuel-number");
  const outputValue = document.querySelector("#number");
  const titleSpan = document.querySelector("#title-number");
  if (inputSlider) {
    inputSlider.addEventListener("input", () => {
      outputValue.value = inputSlider.value;
      titleSpan.textContent = inputSlider.value;
    });
  }
}

export { outputValue };
