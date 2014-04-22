require! {
  jade
  url
  React: react
  Negotiator: negotiator
  shared: \../shared/helpers
  \../shared/react/App
}

export react = (req, res, next) ->
  # only try-catch the synchronous parts
  locals = {} <<< res.locals
  try
    path = url.parse(req.url).pathname
    app  = App {path, locals}
    content = React.render-component-to-string app
  catch
    return next e

  err, html <- render-layout { content, locals }
  if err then throw err
  res.send html

# Figure out whether the requester wants html or json and send the appropriate response
export react-or-json = (req, res, next) ->
    n = new Negotiator(req)
    type = n.media-type <[text/html application/json]>
    switch type
    | \application/json => locals = {} <<< res.locals; res.json locals
    | otherwise         => react(req, res, next)

export common-locals = (req, res, next) ->
  res.locals.js  = shared.js
  res.locals.css = shared.css
  next!


# helpers
# ---------
function render-layout params, next
  jade.render-file \app/views/react-layout.jade, params, next

# vim:fdm=indent
