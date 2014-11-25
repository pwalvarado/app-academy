TrelloClone.Views.ListShowView = Backbone.CompositeView.extend({
  addCard: function (event) {
    var newCardView = new TrelloClone.Views.NewCardView();
    this.$('.cards-container').append(newCardView.render().$el);
  },

  addCards: function (selector) {
    this.collection.each(function (card) {
      var cardView = new TrelloClone.Views.CardShowView({
        model: card
      });
      this.addSubview(selector, cardView.render());
    }.bind(this));
  },

  events: {
    "click a": 'addCard',
    "click .save-card": 'saveCard'
  },

  initialize: function () {
    this.collection = new TrelloClone.Collections.Cards(this.model.attributes.cards);
    this.listenTo(this.collection, 'add', this.render)
  },

  onRender: function () {
    Backbone.CompositeView.prototype.onRender.call(this);
    this.$( ".cards-container" ).sortable({
      appendTo: document.body,
      connectWith: '.cards-container',
      update: function () {
        console.log('working');
      }
    });
  },

  render: function () {
    var content = this.template({ list: this.model });
    this.$el.html(content);
    this.collection && this.addCards('.cards-container');
    this.attachSubviews();
    return this;
  },

  saveCard: function (event) {
    event.preventDefault();
    var cardAttrs = this.$('form').serializeJSON()['card'];
    var newCard = new TrelloClone.Models.Card(cardAttrs);
    newCard.set('list_id', this.model.id)
    newCard.save();
    this.subviews()['.cards-container'] = []
    this.collection.add(newCard);
  },

  template: JST['lists/list_show']
});
