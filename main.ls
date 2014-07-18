global <<< require \prelude-ls
global.React = require \react/addons
global.ReactRouter = require \react-router-component
global.ReactAsync = require \react-async

require! {
  express
  connect: 'express/node_modules/connect'
  \./app/server/mw
  \./app/server/pages
  \./app/server/logs
}

app = express!
app.use connect.logger(immediate: false, format: logs.dev-format)
app.use express.static "#__dirname/public"
app.use pages
app.use (err, req, res, next) ->
  console.error(err)
  res.send 500, err.message

@start-server = (port, path, cb) ->
  app.listen port
  cb null

not-first-time = 0
process.on \SIGUSR2, ->
  if not-first-time++
    console.warn '[restarting]'
    process.exit 0
