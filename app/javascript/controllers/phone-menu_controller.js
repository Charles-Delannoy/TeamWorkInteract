import { Controller } from "stimulus"

export default class extends Controller {

  revealMenu = () => {
    event.currentTarget.classList.toggle('active');
    document.querySelector('.phone-menu').classList.toggle('active');
  }
}
