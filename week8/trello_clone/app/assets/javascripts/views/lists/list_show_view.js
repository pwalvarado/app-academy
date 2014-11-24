TrelloClone.Views.ListShowView = Backbone.View.extend({
  initialize: function () {
    // this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    console.log(this.model);
    var content = this.template({ list: this.model });
    this.$el.html(content);
    return this;
  },

  template: JST['lists/list_show']
});
