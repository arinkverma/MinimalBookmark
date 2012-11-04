Interview.Views.BookmarkTags ||= {}

class Interview.Views.BookmarkTags.EditView extends Backbone.View
  template : JST["backbone/templates/bookmark_tags/edit"]

  events :
    "submit #edit-bookmark_tag" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (bookmark_tag) =>
        @model = bookmark_tag
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
