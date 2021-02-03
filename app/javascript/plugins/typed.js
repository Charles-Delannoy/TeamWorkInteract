import Typed from 'typed.js';

const typedTitle = () => {
  new Typed('#home-typed-text', {
    strings: ["TeamWorkInteract", "Suivez les équipes", "Améliorer leur cohésion"],
    typeSpeed: 120,
    loop: true
  });
}

export { typedTitle };
