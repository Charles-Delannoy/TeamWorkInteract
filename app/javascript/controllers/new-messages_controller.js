import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["count", "card"];
  refresh() {
    const id = this.cardTarget.dataset.chatroomId;
    fetch(`/chatrooms/${id}`, { headers: { accept: "application/json" } })
      .then(response => response.json())
      .then((data) => {
        if (this.countTarget) {
          this.countTarget.innerText = data.count
        } else {
          const notif = data.count === 0 ?
                        `<div class='message-notification'>
                          <p data-target='new-messages.count'>
                            ${data.count}
                          </p>
                        </div>` : null;
          this.cardTarget.insertAdjacentHTML('beforeend', notif);
        }
      })
  }
}
