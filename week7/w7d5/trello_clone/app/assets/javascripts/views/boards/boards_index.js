TrelloClone.Views.BoardsIndexView = Backbone.View.extend({
  render: function () {
    var content = this.template({collection: this.collection});
    this.$el.html(content);
    return this;
  },

  template: JST['boards/index']
});
