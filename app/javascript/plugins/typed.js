import Typed from 'typed.js';

const typed = () => {
  const homeTitle = document.getElementById('home-typed-text');
  if (homeTitle) {
    new Typed('#home-typed-text', {
      strings: ["Créez vos questionnaires", "Suivez vos équipes", "Améliorer leur cohésion"],
      typeSpeed: 120,
      loop: true
    });
  }
}

export { typed };
