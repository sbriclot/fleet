import flatpickr from "flatpickr";
import "flatpickr/dist/themes/material_blue.css";

const formPicker = document.querySelector(".date-picker");
const datepickr = () => {
  flatpickr(formPicker, {
    defaultDate: "today",
    altInput: true,
    allowInput: true,
  });
};

export { datepickr };