export css = [
  * \/css/app.css
]

export js =
  * \/js/vendor.js
  * \/js/app.js

export lpad = (n, str) ->
  if str.length >= n
    str
  else
    Str.repeat(n - str.length, ' ') + str

export rpad = (n, str) ->
  if str.length >= n
    str
  else
    str + Str.repeat(n - str.length, ' ')

  # vim:fdm=indent
