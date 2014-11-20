window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    window.JournalApp.Collections.posts.fetch();
    this.installSidebar();
    
    new JournalApp.Routers.PostsRouter({ $rootEl: $('.content') });
    Backbone.history.start();
  },
  
  installSidebar: function (attribute) {
    var postsIndex = new JournalApp.Views.PostsIndex({
      collection: window.JournalApp.Collections.posts
    });
    $('.sidebar').html(postsIndex.render().$el);
  },
};

$(document).ready(function(){
  JournalApp.initialize();
});