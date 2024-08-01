document.addEventListener('DOMContentLoaded', function() {
  const exchangeDateInput = document.getElementById('exchange_date');
  const nextMaintenanceDayInput = document.getElementById('next_maintenance_day');
  const inspectionInterval = parseInt(document.getElementById('inspection_interval').value, 10);

  exchangeDateInput.addEventListener('change', function() {
    const exchangeDate = new Date(exchangeDateInput.value);
    if (!isNaN(exchangeDate) && inspectionInterval) {
      exchangeDate.setDate(exchangeDate.getDate() + inspectionInterval);
      const nextMaintenanceDay = exchangeDate.toISOString().split('T')[0];
      nextMaintenanceDayInput.value = nextMaintenanceDay;
    }
  });
});