Copse.Views.RenderLogs ||= {}

class Copse.Views.RenderLogs.FormView extends Backbone.View
  template: JST["backbone/templates/render_logs/form"]

  tagName: "form"

  events:
    'submit' : 'submit'

  initialize: ->
    @controllers = ['book','booking','public']
    @actions = ['all','start_checkout','ping']

  submit: (e) ->
    e.preventDefault()
    e.stopPropagation()
    x = @$('#controller')[0]
    controller = x.options[x.selectedIndex].value
    y = @$('#action')[0]
    action = y.options[y.selectedIndex].value
    window.render_logs.url = "/render_logs?selected_controller="+controller+"&selected_action="+action
    window.render_logs.fetch
      success: (response) ->
        console.log 'success'
        console.log response
      error: (response) ->
        console.log 'fail'
        console.log response

  render: ->
    $(@el).html(@template({
      controllers:@controllers
      actions:@actions
    }))
    @$('#start_date').datepicker()
    @$('#end_date').datepicker()
    return this
