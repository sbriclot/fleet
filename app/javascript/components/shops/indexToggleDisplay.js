const indexToggleDisplay = () => {
  const toggleSwitch = document.getElementById("display_all");
  if (toggleSwitch) {
    function toggleDisplay(event) {
      const shops = document.querySelectorAll(".shop.closed");
      console.log(shops);
      shops.forEach((shop) => shop.classList.toggle("hide"));
    }

    toggleSwitch.addEventListener("click", toggleDisplay);
  }
}

export { indexToggleDisplay };
