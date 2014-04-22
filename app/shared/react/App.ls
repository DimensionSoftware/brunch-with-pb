require! {
  \./NotFoundPage
  \../routes
}

# load components referenced in routes.list.
pages = routes.list |> fold ((namespace, route) ->
  c = try
    require "./#{route.0}"
  catch
    console.warn "Could not load #{route.0}", e
  namespace[route.0] = c if c;
  namespace), {}

# Destructure components and mixins from ReactRouter.
{
  Locations,
  Pages,
  Location,
  Page,
  NotFound,
  Link,
  RouterMixin,
  RouteRenderingMixin,
  AsycRouteRenderingMixin,
  NavigatableMixin
} = ReactRouter

module.exports = React.create-class {
  display-name: \App
  mixins: [ NavigatableMixin ]

  location: (route) ->
    name = route.0
    Location { ref: name, path: route.1, handler: pages[name], async-state: @props.locals }

  render: ->
    # make Location components for every routable component
    locations-for-routes = (routes.list |> filter (-> pages[it.0]) |> map (~> @location it))

    Locations { ref: \Locations, path: @props.path }, [
      # add routable components to Locations
      ...locations-for-routes,
      NotFound { ref: \NotFoundPage, handler: NotFoundPage }
    ]
}
