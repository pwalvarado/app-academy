TrelloClone.Routers.AppRouter = Backbone.Router.extend({
  boardIndex: function () {
    console.log('here');
    var boards = new TrelloClone.Collections.Boards();
    boards.fetch();
    boardsIndexView = new TrelloClone.Views.BoardsIndexView({ collection: boards, el: $('#main') });
    this.$rootEl.html(boardsIndexView.render().$el);
  },

  initialize: function ($rootEl) {
    this.$rootEl = $rootEl;
  },

  routes: {
    '': 'boardIndex',
    'boards/:id': 'showBoard'
  },

  showBoard: function (id) {
    var board = new TrelloClone.Models.Board({ id: id });
    board.fetch();
    var boardShowView = new TrelloClone.Views.BoardShowView({ model: board });
    this.$rootEl.html(boardShowView.render().$el);
  }
});
