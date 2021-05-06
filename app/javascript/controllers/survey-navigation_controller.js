import { Controller } from "stimulus"

export default class extends Controller {

  navigate = (e) => {
    const activeTag = document.querySelector('.question-access.active');
    const currentQuestion = document.querySelector(`.${activeTag.dataset.question}`);
    currentQuestion.classList.add('hidden-question');
    const nextQuestion = document.querySelector(`.${e.currentTarget.dataset.question}`);
    nextQuestion.classList.remove('hidden-question');
    activeTag.classList.remove('active');
    e.currentTarget.classList.add('active');
  }
}
