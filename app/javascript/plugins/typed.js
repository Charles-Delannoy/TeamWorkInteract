import Typed from 'typed.js';

const typed = () => {
  if (document.getElementById('#home-typed-text')) {
    new Typed('#home-typed-text', {
      strings: ["TeamWorkInteract", "Suivez les équipes", "Améliorer leur cohésion"],
      typeSpeed: 120,
      loop: true
    });
  }
}

export { typed };
