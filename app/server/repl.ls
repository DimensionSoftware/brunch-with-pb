require 'LiveScript'
global.cl = console.log
global.cw = console.warn
global.config = require './config'
global.routes = require './routes'
global.handlers = require './handlers'
global <<< require \prelude-ls
global.app =
  config: config.load!
  routes: global.routes
  model: {}
