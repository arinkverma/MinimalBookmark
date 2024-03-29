class Interview.Routers.TagsRouter extends Backbone.Router
  initialize: (options) ->
    @tags = new Interview.Collections.TagsCollection()
    @tags.reset options.tags

  routes:
    "new"      : "newTag"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newTag: ->
    @view = new Interview.Views.Tags.NewView(collection: @tags)
    $("#tags").html(@view.render().el)

  index: ->
    @view = new Interview.Views.Tags.IndexView(tags: @tags)
    $("#tags").html(@view.render().el)

  show: (id) ->
    tag = @tags.get(id)

    @view = new Interview.Views.Tags.ShowView(model: tag)
    $("#tags").html(@view.render().el)

  edit: (id) ->
    tag = @tags.get(id)

    @view = new Interview.Views.Tags.EditView(model: tag)
    $("#tags").html(@view.render().el)
