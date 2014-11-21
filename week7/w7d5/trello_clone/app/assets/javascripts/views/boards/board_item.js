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
    console.log('show board ' + this.model.id);
    var board = this.collection.get(this.model.id);
    board.fetch();
    var boardShowView = new TrelloClone.Views.BoardShowView({ model: board });
    this.$el.html(boardShowView.render().$el);
  },

  template: JST['boards/board_item']
});
