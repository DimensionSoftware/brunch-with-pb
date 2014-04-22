require 'LiveScript'

global.cl = console.log
global.cw = console.warn
global <<< require \prelude-ls

global.React = require \react/addons
global.ReactRouter = require \react-router-component
global.ReactAsync = require \react-async

global.routes = require '../shared/routes'

global.reload = (m) ->
  paths = require.resolve m
  if is-type \String, paths
    delete require.cache[paths]
  else
    paths.for-each (p) -> delete require.cache[p]
  require m

# vim:fdm=indent
