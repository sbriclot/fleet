// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

  // Support component names relative to this directory:
// const componentRequireContext = require.context("components", true);
// const ReactRailsUJS = require("react_ujs");
// ReactRailsUJS.useContext(componentRequireContext);

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

import { indexToggleDisplay } from "../components/shops/indexToggleDisplay";
import { refuelChart, averageChart } from "../plugins/_init_chartjs";
import { outputValue } from "../components/refuels/outputSliderValue.js";
import { changeMaintenancePlan } from "../components/operations/changeMaintenancePlan";
import { updateVehicleFuels } from "../components/vehicles/updateVehicleFuels";

document.addEventListener("turbolinks:load", () => {
  // Call your functions here, e.g:
  // initSelect2();
  indexToggleDisplay();
  refuelChart();
  averageChart();
  outputValue();
  changeMaintenancePlan();
  updateVehicleFuels();
});
