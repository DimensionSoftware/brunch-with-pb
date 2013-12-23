@init = (app) ->
  { [ k, (...args) -> fn.apply app, args ] for k,fn of @ when k isnt \apply }

@home = (req, res, next) ->
  console.log @something
  res.send \home
