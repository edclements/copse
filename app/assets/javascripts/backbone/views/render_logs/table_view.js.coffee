Copse.Views.RenderLogs ||= {}

class Copse.Views.RenderLogs.TableView extends Backbone.View
  tagName: "table"

  className: "render_log"

  events:
    'click th' : 'clickHeader'
    'click td.session_id' : 'clickSession'

  initialize: ->
    @collection = @options.collection
    @columns = ['time','completed_time','db_time','controller','action','session_id','url','status_code']
    @collection.bind('reset', @render)

  addAll: (collection) ->
    console.log 'table view add all'
    @$('tbody').append('<tr></tr>')
    for header in @columns
      @$('tr').append('<th id="'+header+'">'+header+'</th>')
    collection.each (model) =>
      @addModel(model)

  addModel: (model) ->
    view = new Copse.Views.RenderLogs.TableRowView
      model : model
      columns : @columns
    @$('tr').last().after(view.render().el)

  clickHeader: (e) ->
    @collection.setOrderBy(e.target.id)

  clickSession: (e) ->
    @collection.url.removeSearch('session_id')
    @collection.url.addSearch('session_id', e.target.innerHTML)
    @collection.fetch
      success: ->
        console.log 'success'
      fail: ->
        console.log 'fail'

  render: =>
    $(@el).html("<tbody></tbody>")
    @addAll(@collection)
    if @collection.order_dir == 'asc'
      @$('#'+@collection.order_by).html(@collection.order_by+' (+)')
    if @collection.order_dir == 'desc'
      @$('#'+@collection.order_by).html(@collection.order_by+' (-)')
    return this
