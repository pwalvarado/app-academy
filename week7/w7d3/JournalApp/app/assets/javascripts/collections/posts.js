window.JournalApp.Collections.Posts = Backbone.Collection.extend({
  getOrFetch: function (id) {
    var posts = this;
    
    var post;
    if (!(post = this.get(id))) {
      post = new JournalApp.Models.Post({ 'id': id });
      post.fetch({
        success: function () { posts.add(post); }
      });
    }
    
    return post;
  },
  url: "/posts",
  model: JournalApp.Models.Post
});

window.JournalApp.Collections.posts = new JournalApp.Collections.Posts();