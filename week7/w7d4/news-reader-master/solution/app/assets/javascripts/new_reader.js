window.NewReader = {
    Models: {},
    Collections: {},
    Views: {},
    Routers: {},
    initialize: function() {
      var $rootEl = $('#content');
      var $sidebar = $('#sidebar');
      var feeds = new NewReader.Collections.Feeds();
      feeds.fetch();

      // install the sidebar external to the router as it is
      // independent of any routing
      var feedsIndexView = new NewReader.Views.FeedsIndex({
        collection: feeds
      });
      $sidebar.html(feedsIndexView.render().$el);

      new NewReader.Routers.FeedRouter(feeds, $rootEl);
      Backbone.history.start();
    }
};
