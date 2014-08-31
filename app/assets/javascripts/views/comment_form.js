Prosody.Views.CommentForm = Backbone.View.extend({
  template: JST["comments/form"],

  events: {
    'submit .new-comment': 'submit'
  },

  render: function () {
    var renderedContent = this.template({
      comment: this.model
    });
    this.$el.html(renderedContent);

    return this;
  },

  submit: function (event) {
    var that = this

    event.preventDefault();

    var attrs = $(event.target).serializeJSON();

    attrs['comment']['annotation_id'] = this.collection.annotation.id;

    function success () {
      that.collection.fetch();
    }

    this.model.set(attrs);



    if (this.model.isNew()) {
      this.collection.create(this.model, {
        success: success,
        wait: true
      });
    } else {
      this.model.save({}, {
        success: success
      });
    }
  }

})