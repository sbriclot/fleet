const updateVehicleFuels = () => {
  const checkboxes = document.querySelectorAll(".tag-selector");
  if (checkboxes) {
    function updateFlag(event) {
      document.getElementById("vf-update").submit();
    }

    checkboxes.forEach((checkbox) => checkbox.addEventListener("click", updateFlag));
  }
}

export { updateVehicleFuels };
