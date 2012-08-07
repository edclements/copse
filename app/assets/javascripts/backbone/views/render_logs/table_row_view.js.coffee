Copse.Views.RenderLogs ||= {}

class Copse.Views.RenderLogs.TableRowView extends Backbone.View
  tagName: "tr"

  initialize: ->
    @columns = @options.columns

  render: ->
    for attribute in @columns
      $(@el).append('<td>'+@model.get(attribute)+'</td>')
    return this
