document.addEventListener('turbo:load', function() {
  const exchangeDateInput = document.getElementById('exchange_date');
  const nextMaintenanceDayInput = document.getElementById('next_maintenance_day');
  const inspectionIntervalElement = document.getElementById('inspection_interval');
  const inspectionInterval = inspectionIntervalElement ? parseInt(inspectionIntervalElement.value, 10) : 0;

  if (exchangeDateInput && nextMaintenanceDayInput && inspectionInterval) {
    exchangeDateInput.addEventListener('change', function() {
      const exchangeDate = new Date(exchangeDateInput.value);
      if (!isNaN(exchangeDate)) {
        exchangeDate.setDate(exchangeDate.getDate() + inspectionInterval);
        const nextMaintenanceDay = exchangeDate.toISOString().split('T')[0];
        nextMaintenanceDayInput.value = nextMaintenanceDay;
      }
    });
  }
});