TrelloClone.Views.ListShowView = Backbone.CompositeView.extend({
  addCard: function (event) {
    var newCardView = new TrelloClone.Views.NewCardView();
    this.$('.cards-container').append(newCardView.render().$el);
  },

  addCards: function (selector) {
    this.model.attributes.cards.forEach(function (cardAttrs) {
      var card = new TrelloClone.Models.Card(cardAttrs);
      var cardView = new TrelloClone.Views.CardShowView({
        model: card,
        className: 'card'
      });
      this.addSubview(selector, cardView.render());
    }.bind(this));
  },

  events: {
    "click a": 'addCard'
  },

  initialize: function () {
    // this.listenTo(this.collection, 'sync', this.render);
  },

  onRender: function () {
    Backbone.CompositeView.prototype.onRender.call(this);
    this.$( ".cards-container" ).sortable({
      appendTo: document.body,
      connectWith: '.cards-container',
      tolerance: 'pointer'
    });
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
