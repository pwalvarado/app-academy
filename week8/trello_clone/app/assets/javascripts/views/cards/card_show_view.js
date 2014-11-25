TrelloClone.Views.CardShowView = Backbone.View.extend({
  className: 'card',

  events: {
    'click .delete-button': 'removeCard'
  },

  removeCard: function (event) {
    event.preventDefault();
    this.model.destroy();
    this.remove();
  },

  render: function () {
    var content = this.template({ card: this.model })
    this.$el.html(content);
    return this;
  },

  template: JST['cards/card_show']
})
