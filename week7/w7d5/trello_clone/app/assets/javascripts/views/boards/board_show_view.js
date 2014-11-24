TrelloClone.Views.BoardShowView = Backbone.View.extend({
  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    console.log('board title');
    console.log(this.model.attributes.title);
    console.log('board lists');
    console.log(this.model.attributes.lists);
    console.log('board cards');
    console.log(this.model.attributes.lists[1].cards);
    var content = this.template({ board: this.model });
    this.$el.html(content);
    return this;
  },

  template: JST['boards/board_show']
});
