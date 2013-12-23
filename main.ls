# What are we made of?
#
# config = {} # derived from environment like environ.clj
# routes = {} # object that can be fed into express
# model = {}  # object full of state manipulation functions
#
# app = new App {config, model, routes}
#

require! {
  express
  \./app/server/config
  \./app/server/handlers
  \./app/server/routes
}

app =
  config: config.load!
  routes: routes

exp = express!

@start-server = (port, path, cb) ->
  exp.listen port
  cb null
