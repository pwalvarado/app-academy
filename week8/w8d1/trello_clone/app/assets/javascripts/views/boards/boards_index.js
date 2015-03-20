TrelloClone.Views.BoardsIndexView = Backbone.CompositeView.extend({
  addBoardItems: function (selector) {
    this.collection.each(function (board) {
      var boardItemView = new TrelloClone.Views.BoardItem({
        model: board, collection: this.collection
      });
      this.addSubview(selector, boardItemView);
    }.bind(this));
  },

  initialize: function () {
    this.listenTo(this.collection, 'sync', this.render);
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.addBoardItems('#board-items');
    this.attachSubviews();
    return this;
  },

  template: JST['boards/index']
});
