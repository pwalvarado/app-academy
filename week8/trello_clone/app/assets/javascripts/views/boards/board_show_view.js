TrelloClone.Views.BoardShowView = Backbone.CompositeView.extend({
  addLists: function (selector) {
    this.model.attributes.lists.forEach(function (listAttrs) {
      var list = new TrelloClone.Models.List(listAttrs);
      var listView = new TrelloClone.Views.ListShowView({
        model: list,
        className: 'list'
      });
      this.addSubview(selector, listView);
    }.bind(this));
  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    this.model.attributes.lists && this.addLists('#lists-container');
    this.attachSubviews();
    $( "#lists-container" ).sortable({ appendTo: document.body });
    return this;
  },

  template: JST['boards/board_show']
});
