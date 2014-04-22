require! {
  \express
  \./mw
  '../shared/routes'
}

{r,rn} = routes

app = module.exports = express!

app.set 'view engine', 'jade'
app.set 'views', 'app/views'

app.get \/favicon.ico, (req, res) -> res.send 404

app.get r(\HomePage),
  mw.common-locals,
  ((req, res, next) ->
    res.locals.title = \Home
    res.locals.count = 1
    next!),
  mw.react-or-json

app.get r(\AboutPage),
  ((req, res, next) ->
    res.locals.title = 'Make a Selection to Drill Down'
    next!),
  mw.react-or-json

# vim:fdm=indent
