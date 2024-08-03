// 点検作業日を選択すると自動的に次回交換予定日が計算されて入力される //
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


