Interview.Views.BookmarkTags ||= {}

class Interview.Views.BookmarkTags.BookmarkTagView extends Backbone.View
  template: JST["backbone/templates/bookmark_tags/bookmark_tag"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
