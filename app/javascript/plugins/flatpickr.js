import flatpickr from "flatpickr";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

const initFlatpicker = () => {
  if (document.getElementById("range_start")) {

    let calendar = flatpickr("#range_start", {
      altInput: true,
      inline: true,
      plugins: [new rangePlugin({ input: "#range_end"})]
    });
    calendar.clear();

  } else if (document.getElementById("range_start_edit")) {

    let calendar_edit = flatpickr("#range_start_edit", {
      altInput: true,
      inline: true,
      plugins: [new rangePlugin({ input: "#range_end"})]
    });

  }
}

export { initFlatpicker };
