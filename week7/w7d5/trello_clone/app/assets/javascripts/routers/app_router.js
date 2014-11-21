TrelloClone.Routers.AppRouter = Backbone.Router.extend({
  boardIndex: function () {
    var boards = new TrelloClone.Collections.Boards();
    boards.fetch({
      success: function () {
        var boardsIndexView = new TrelloClone.Views.BoardsIndexView({
          collection: boards
        });
        this.$rootEl.html(boardsIndexView.render().$el);
      }.bind(this)
    });
  },

  initialize: function ($rootEl) {
    this.$rootEl = $rootEl;
  },

  routes: {
    '': 'boardIndex'
  }
});
