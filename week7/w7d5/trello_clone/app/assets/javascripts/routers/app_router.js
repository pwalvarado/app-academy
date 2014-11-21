TrelloClone.Routers.AppRouter = Backbone.Router.extend({
  boardIndex: function () {
    var boards = new TrelloClone.Collections.Boards();
    boardsIndexView = new TrelloClone.Views.BoardsIndexView({ collection: boards});
    boards.fetch();
    this.$rootEl.html(boardsIndexView.render().$el);
  },

  initialize: function ($rootEl) {
    this.$rootEl = $rootEl;
  },

  routes: {
    '': 'boardIndex'
  }
});
