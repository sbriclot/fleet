const updateVehicleFuels = () => {
  const checkboxes = document.querySelectorAll(".tag-selector");
  if (checkboxes) {
    function updateFlag(event) {
      console.log(this.checked);
    }

    checkboxes.forEach((checkbox) => checkbox.addEventListener("click", updateFlag));
  }
}

export { updateVehicleFuels };
