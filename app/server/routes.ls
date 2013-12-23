require! {
  \./handlers
}

@init = ->


@list = [
  # [ method, pattern, functions ]
  [\get, \/, [handlers.home]]
]
