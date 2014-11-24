TrelloClone.Views.BoardItem = Backbone.View.extend({
  events: {
    'click': 'showBoard'
  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    return this;
  },

  showBoard: function () {
    Backbone.history.navigate('/' + this.model.url());
  },

  template: JST['boards/board_item']
});
