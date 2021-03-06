const chatBottomScroll = () => {
  const chat = document.getElementById('chat-content');
  if (chat) {
    chat.scrollTop = chat.scrollHeight;
  }
}

export { chatBottomScroll };







