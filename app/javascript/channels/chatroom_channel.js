import consumer from "./consumer";
import { chatBottomScroll } from "../plugins/chatBottomScroll";

const displayMessage = (data, messagesContainer) => {
  console.log(`message-${data[1]}`);
  const sender = document.getElementById(`message-${data[1]}`)
  if (!sender) {
    const message = `<div class='message-content'>${data[0]}</div>`;
    console.log(message)
    messagesContainer.insertAdjacentHTML('beforeend', message);
    chatBottomScroll();
  }
}

const initChatroomCable = () => {
  const messagesContainer = document.getElementById('chat-content');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;
    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        setTimeout(() => displayMessage(data, messagesContainer), 100);
      },
    });
  }
}

export { initChatroomCable };
