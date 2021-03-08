import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["count", "card"];

  connect() {
    setInterval(this.refresh, 3000)
  }

  refresh = () => {
    const id = this.cardTarget.dataset.chatroomId;
    fetch(`/chatrooms/${id}`, { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        console.log(this.countTarget);
        if (parseInt(this.countTarget.innerText, 10) < data.counter) {
          this.countTarget.classList.remove('d-none');
          this.countTarget.innerText = data.counter;
        }
      })
  }
}
