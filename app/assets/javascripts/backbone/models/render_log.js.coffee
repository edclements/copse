class Copse.Models.RenderLog extends Backbone.Model
  paramRoot: 'render_log'

  defaults:
    ''

class Copse.Collections.RenderLogsCollection extends Backbone.Collection
  model: Copse.Models.RenderLog
  url: '/render_logs'
