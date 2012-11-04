class Interview.Models.Tag extends Backbone.Model
  paramRoot: 'tag'

  defaults:
    name: null

class Interview.Collections.TagsCollection extends Backbone.Collection
  model: Interview.Models.Tag
  url: '/tags'
