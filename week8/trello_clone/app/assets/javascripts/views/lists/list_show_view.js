TrelloClone.Views.ListShowView = Backbone.CompositeView.extend({
  addCards: function (selector) {
    this.model.attributes.cards.forEach(function (cardAttrs) {
      var card = new TrelloClone.Models.Card(cardAttrs);
      var cardView = new TrelloClone.Views.CardShowView({
        model: card,
        className: 'card'
      });
      console.log(cardView);
      this.addSubview(selector, cardView.render());
    }.bind(this));
  },

  initialize: function () {
    // this.listenTo(this.collection, 'sync', this.render);
  },

  render: function () {
    var content = this.template({ list: this.model });
    this.$el.html(content);
    this.model.attributes.cards && this.addCards('.cards-container');
    this.attachSubviews();
    return this;
  },

  template: JST['lists/list_show']
});
