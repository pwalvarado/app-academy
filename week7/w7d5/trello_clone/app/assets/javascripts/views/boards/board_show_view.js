TrelloClone.Views.BoardShowView = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    console.log('you are here');
    var content = this.template({ board: this.model });
    this.$el.html(content);
    return this;
  },

  template: JST['boards/board_show']
});
