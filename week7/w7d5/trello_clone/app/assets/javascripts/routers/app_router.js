TrelloClone.Routers.AppRouter = Backbone.Router.extend({
  boardIndex: function () {
    var boards = new TrelloClone.Collections.Boards();
    boardsIndexView = new TrelloClone.Views.BoardsIndexView({ collection: boards, el: $('#board-index') });
    boards.fetch();
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
    console.log('show board ' + id);
    var board = new TrelloClone.Models.Board({ id: id });
    board.fetch({
      success: function () {
        console.log(board);
      }
    });
    var boardShowView = new TrelloClone.Views.BoardShowView({ model: board });
    this.$rootEl.html(boardShowView.render().$el);
  }
});
