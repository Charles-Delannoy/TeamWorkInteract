import { Controller } from "stimulus"

export default class extends Controller {

  navigate = (e) => {
    const activeTag = document.querySelector('.question-access.active');
    activeTag.classList.remove('active');
    const currentQuestion = document.querySelector(`.${activeTag.dataset.question}`);
    currentQuestion.classList.add('hidden-question');
    const nextQuestion = document.querySelector(`.${e.currentTarget.dataset.question}`);
    nextQuestion.classList.remove('hidden-question');
    e.currentTarget.classList.add('active');
    document.querySelector('.back').classList.remove('hidden-button');
    document.querySelector('.next').classList.remove('hidden-button');
    if ((e.currentTarget.nextElementSibling === null)) {
      document.querySelector('.next').classList.add('hidden-button');
    } else if (!(e.currentTarget.previousElementSibling.classList[0] === "question-access")) {
      document.querySelector('.back').classList.add('hidden-button');
    }
  }

  next = (e) => {
    e.preventDefault();
    const nextTag = document.querySelector('.question-access.active').nextElementSibling;
    nextTag.click();
  }

  previous = (e) => {
    e.preventDefault();
    const prevTag = document.querySelector('.question-access.active').previousElementSibling;
    prevTag.click();
  }
}
