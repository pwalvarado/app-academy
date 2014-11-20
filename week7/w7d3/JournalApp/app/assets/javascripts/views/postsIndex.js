window.JournalApp.Views.PostsIndex = Backbone.View.extend({
  
  destroyPost: function (event) {
    var postId = $(event.target).data('id');
    var post = this.collection.get(postId);
    post.destroy();
  },
  
  events: {
    'click .delete-button': 'destroyPost'
  },
  
  initialize: function() {
    this.listenTo(this.collection, 
      'remove add change:title remove reset', 
      function () {
        this.render();
      }.bind(this))
  },
  
  render: function () {
    var content = this.template({ posts: this.collection });
    this.$el.html(content);
    return this;
  },
  
  template: JST['index']
  
});