Copse.Views.RenderLogs ||= {}

class Copse.Views.RenderLogs.ListItemView extends Backbone.View
  # template: JST["backbone/templates/render_logs/list_item"]

  tagName: "li"

  className: "render_log"

  render: ->
    $(@el).html(@model.json)
    # $(@el).html(@template(@model.json))
    return this
