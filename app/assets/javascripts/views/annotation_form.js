Prosody.Views.AnnotationForm = Backbone.View.extend({
  template: JST["annotations/form"],

  events: {
    'submit .new-annotation': 'submit'
  },

  render: function () {
    var renderedContent = this.template({
      annotation: this.model
    });
    this.$el.html(renderedContent);

    return this;
  },

  submit: function (event) {
      event.preventDefault();

      var attrs = $(event.target).serializeJSON();
      attrs['article_id'] = this.collection.article.id
      console.log(attrs)

      function success () {
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