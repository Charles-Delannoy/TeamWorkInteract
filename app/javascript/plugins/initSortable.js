import Sortable from 'sortablejs';

const initGroupSortable = (ulElements) => {
  ulElements.forEach((ul) => {
    new Sortable(ul, {
      group: 'group', //set both lists to same group
      animation: 300
    });
  });
};

export { initGroupSortable };