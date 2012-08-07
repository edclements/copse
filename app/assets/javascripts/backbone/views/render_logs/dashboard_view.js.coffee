Copse.Views.RenderLogs ||= {}

class Copse.Views.RenderLogs.DashboardView extends Backbone.View
  tagName: "div"

  initialize: ->
    console.log 'dashboard view'

  render: ->
    table_view = new Copse.Views.RenderLogs.TableView
      collection : window.render_logs
    form_view = new Copse.Views.RenderLogs.FormView()
    $(@el).append(form_view.render().el)
    $(@el).append(table_view.render().el)
    return this
