window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    window._feeds = new NewsReader.Collections.Feeds();
    new NewsReader.Routers.AppRouter($("#content"));
    Backbone.history.start(); 
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});