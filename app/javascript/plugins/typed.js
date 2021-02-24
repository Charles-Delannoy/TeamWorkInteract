import Typed from 'typed.js';

const typed = () => {
  const homeTitle = document.getElementById('home-typed-text');
  if (homeTitle) {
    new Typed('#home-typed-text', {
      strings: ["Identifiez des axes d'améliorations", "Proposer des actions correctives", "Suivez leur évolution"],
      typeSpeed: 80,
      loop: true
    });
  }
}

export { typed };
