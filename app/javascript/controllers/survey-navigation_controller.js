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
  }
}
