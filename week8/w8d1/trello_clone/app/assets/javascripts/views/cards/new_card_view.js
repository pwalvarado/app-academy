TrelloClone.Views.NewCardView = Backbone.CompositeView.extend({
  events: {
    // "click a": 'addCard'
  },

  initialize: function () {
    // this.listenTo(this.collection, 'sync', this.render);
    this.model = new TrelloClone.Models.Card();
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  template: JST['cards/new_card']
});
