class Copse.Models.RenderLog extends Backbone.Model
  paramRoot: 'render_log'

  defaults:
    ''

class Copse.Collections.RenderLogsCollection extends Backbone.Collection
  model: Copse.Models.RenderLog

  initialize: ->
    @url = URI('/render_logs')
    @url.addSearch('limit', 20)

  setOrderBy: (column) ->
    if @order_by == column
      if @order_dir == 'asc'
        @order_dir = 'desc'
      else
        @order_dir = 'asc'
    else
      @order_dir = 'asc'
    @order_by = column
    @url.removeSearch('order_by')
    @url.addSearch('order_by', @order_by)
    @url.removeSearch('order_dir')
    @url.addSearch('order_dir', @order_dir)
    @fetch
      success: ->
        console.log 'success'
      error: ->
        console.log 'fail'
