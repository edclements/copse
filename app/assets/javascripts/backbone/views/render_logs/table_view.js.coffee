Copse.Views.RenderLogs ||= {}

class Copse.Views.RenderLogs.TableView extends Backbone.View
  tagName: "table"

  className: "render_log"

  initialize: ->
    @collection = @options.collection
    @columns = ['time','completed_time','controller','action']
    @collection.bind('reset', @render)

  addAll: (collection) ->
    console.log 'table view add all'
    @$('tbody').append('<tr></tr>')
    for header in @columns
      @$('tr').append('<th>'+header+'</th>')
    collection.each (model) =>
      @addModel(model)

  addModel: (model) ->
    view = new Copse.Views.RenderLogs.TableRowView
      model : model
      columns : @columns
    @$('tr').last().after(view.render().el)

  render: =>
    $(@el).html("<tbody></tbody>")
    @addAll(@collection)
    return this
