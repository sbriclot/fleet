function outputValue() {
  const inputSlider = document.querySelector("#refuel_number");
  const outputValue = document.querySelector("#number");
  if (inputSlider) {
    inputSlider.addEventListener("input", ()=>{
      outputValue.value = inputSlider.value
    });
  }
}

export { outputValue };
