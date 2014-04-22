require! {
  shared: '../shared/helpers'
}

export dev-format = (tokens, req, res) ->
  status = res.status-code
  len    = parse-int res.get-header(\Content-Length), 10
  color  = switch
  | status >= 500 => 31
  | status >= 400 => 31
  | status >= 300 => 36
  | otherwise     => 32

  len = if is-NaN len then '' else len
  "\x1b[38;5;222m#{shared.lpad 7, req.method} \x1b[90m(\x1b[#{color}m#{res.status-code}\x1b[90m) \x1b[38;5;255m#{req.host}#{req.originalUrl} \x1b[38;5;197m#{new Date - req._start-time}ms - #{len}\x1b[0m"
