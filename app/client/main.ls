window <<< window.prelude

require! \../shared/react/App

# intialize App on client-side
$(->
  window.app = React.render-component App({ path: window.location.pathname, locals: window.locals }), ($ \#main).0

  # hijack surf clicks (for now)
  $ document .on \click, \.surf, (ev) ->
    ev.prevent-default!
    window.app.navigate ($ ev.current-target .attr \href), {}
)

# vim:fdm=indent
