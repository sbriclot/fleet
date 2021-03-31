const changeMaintenancePlan = () => {
  const mpSelectList = document.getElementById("operation_maintenance_plan_id");
  if (mpSelectList) {
    function populateOpsFields() {
      const mp = JSON.parse(this.value);
      const opsTask = document.getElementById("operation_task");
      const opsDetails = document.getElementById("operation_details");
      opsTask.value = mp.task;
      opsDetails.value = mp.details;
    };
    mpSelectList.addEventListener('change', populateOpsFields);
  }
};

export {changeMaintenancePlan};