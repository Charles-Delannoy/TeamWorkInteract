import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["arrow"];

  hideOrShow = () => {
    const elmt = document.getElementById(this.arrowTarget.dataset.campaign);
    elmt.classList.toggle('deployed')
    this.arrowTarget.classList.toggle('return');
  }
}
