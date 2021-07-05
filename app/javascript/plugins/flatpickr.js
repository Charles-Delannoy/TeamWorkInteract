import flatpickr from "flatpickr";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

const initFlatpicker = () => {
  const resetBtn = document.getElementById('reset-dates');

  if (document.getElementById("range_start") || document.getElementById("range_start_edit")) {

    const calendarId = document.getElementById("range_start") ? '#range_start' : '#range_start_edit';

    const calendar = flatpickr(calendarId, {
      altInput: true,
      inline: true,
      plugins: [new rangePlugin({ input: "#range_end"})]
    });

    resetBtn.addEventListener('click', (e) => {
      e.preventDefault();
      calendar.clear();
    })
  }
}

export { initFlatpicker };
