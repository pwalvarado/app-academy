TrelloClone.Views.BoardsIndexView = Backbone.View.extend({
  addSubviews: function () {
    this.subviews = [];
    this.collection.each(function (board) {
      var subview = new TrelloClone.Views.BoardItem({
        model: board, collection: this.collection
      });
      this.subviews.push(subview);
    }.bind(this));
  },

  events: {
    'click': 'showBoard'
  },

  initialize: function () {
    this.listenTo(this.collection, 'sync add remove', this.render);
  },

  render: function () {
    this.$el.empty();
    this.addSubviews();
    this.subviews.forEach(function (subview) {
      this.$el.append(subview.render().$el);
    }.bind(this));
    return this;
  },

  template: JST['boards/index']
});
