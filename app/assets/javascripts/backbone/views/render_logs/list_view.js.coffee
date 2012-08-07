Copse.Views.RenderLogs ||= {}

class Copse.Views.RenderLogs.ListView extends Backbone.View
  tagName: "ul"

  className: "render_log"

  addAll: (collection) ->
    collection.each(model) ->
      @addModel(model)

  addModel: (model) ->
    view = new Copse.Views.RenderLogs.ListItemView(model:model)
    $(@el).html(view.render().el)

  render: ->
    return this
