{div,span,h1} = React.DOM
{Link} = ReactRouter

require! {
  \./mixins
  \../routes
}

{r,rn} = routes

module.exports = React.create-class {
  display-name: \HomePage
  mixins: [ReactAsync.mixin, mixins.InitialStateAsync]
  render: ->
    div void, [
      h1 void, [ "Home" ]
      h1 void, [
        Link href: r(\AboutPage), [ "About" ]
      ]
    ]
}
