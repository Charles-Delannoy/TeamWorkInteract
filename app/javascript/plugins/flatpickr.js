import flatpickr from "flatpickr";
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

const initFlatpicker = () => {

  flatpickr("#range_start", {
    altInput: true,
    inline: true,
    plugins: [new rangePlugin({ input: "#range_end"})]
  });
}

export { initFlatpicker };
