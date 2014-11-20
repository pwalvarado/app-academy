window.JournalApp.Views.PostForm = Backbone.View.extend({
  commitPost: function (event) {
    event.preventDefault();
    var attributes = $(event.currentTarget).serializeJSON();
    this.model.save(attributes, {
      success: function(model) {
        JournalApp.Collections.posts.add(this.model);
        Backbone.history.navigate("#/", { trigger: true} )
      },
      error: function() {
        var post = new JournalApp.Models.Post(attributes);
        postForm = new JournalApp.Views.PostForm({model: post});
        postForm.render();
      }.bind(this)
    });
  },
  
  events: {
    'submit #post-form': 'commitPost'
  },
  
  render: function () {
    var content = this.template({ 
      post: this.model 
    });
    this.$el.html(content);
    return this;
  },
  
  template: JST['post_form']
});