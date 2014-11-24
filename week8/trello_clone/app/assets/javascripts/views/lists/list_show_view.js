TrelloClone.Views.ListShowView = Backbone.CompositeView.extend({
  addCards: function (selector) {
    this.model.cards.forEach(function (card) {
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
    this.model.cards && this.addCards('#cards-container');
    this.attachSubviews();
    return this;
  },

  template: JST['lists/list_show']
});
