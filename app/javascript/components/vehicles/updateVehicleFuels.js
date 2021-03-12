const updateVehicleFuels = () => {
  const checkboxes = document.querySelectorAll(".tag-selector");
  if (checkboxes) {
    function updateFlag(event) {
      // init varaiables
      const frm = document.getElementById("vf-update");
      const cbFuelId= document.getElementById('cb-fuel-id');
      const cbChecked = document.getElementById('cb-checked');

      //  set value to send to the controller
      cbFuelId.value = this.value;
      cbChecked.value = this.checked;
      //  submit the form
      frm.submit();
      // reset the hidden fields (frm.reset() doesn't work)
      cbFuelId.value = "";
      cbChecked.value = "";
    }

    checkboxes.forEach((checkbox) => checkbox.addEventListener("click", updateFlag));
  }
}

export { updateVehicleFuels };
