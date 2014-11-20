window.JournalApp.Routers.PostsRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },
  
  routes: {
    "": "postsIndex",
    "posts/new": "postNew",
    "posts/:id": "postShow",
    "posts/:id/edit": "postEdit"
  },
  
  postNew: function(){
    var post = new JournalApp.Models.Post();
    var postForm = new JournalApp.Views.PostForm({
      model: post
    });
    
    postForm.render();
    this.$rootEl.html(postForm.$el);
  },
  
  postEdit: function (id) {
    var post = JournalApp.Collections.posts.getOrFetch(id);
    var postForm = new JournalApp.Views.PostForm({
      model: post
    });
    
    post.fetch({
      success: function () {
        postForm.render();
        this.$rootEl.html(postForm.$el);
      }.bind(this)
    })
  },
  
  postsIndex: function () {
    // var posts = JournalApp.Collections.posts;
    var postsIndex = new JournalApp.Views.PostsIndex({
      collection: window.JournalApp.Collections.posts
    });
    
    // posts.fetch({
 //      success: function () {
    postsIndex.render();
    this.$rootEl.html(postsIndex.$el);
      // }.bind(this)
  //   });
  },
  
  postShow: function (id) {
    var post = JournalApp.Collections.posts.getOrFetch(id);
    var postShow = new JournalApp.Views.PostShow({model: post});
    postShow.render();
    this.$rootEl.html(postShow.$el);
    post.fetch();
    // post.fetch({
    //   success: function () {
    //     postShow.render();
    //     this.$rootEl.html(postShow.$el);
    //   }.bind(this)
    // })
  },

});