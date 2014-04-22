exports.config =
  # See http://brunch.readthedocs.org/en/latest/config.html for documentation.
  files:
    javascripts:
      joinTo:
        'js/app.js': /^app\/(client|shared)/
        'js/vendor.js': /^vendor/
        'test/js/test.js': /^test(\/|\\)(?!vendor)/
        'test/js/test-vendor.js': /^test(\/|\\)(?=vendor)/
      order:
        # Files in `vendor` directories are compiled before other files
        # even if they aren't specified in order.before.
        before: [
          'vendor/scripts/react-with-addons-0.10.0.js',
        ]

    stylesheets:
      joinTo:
        'css/app.css': /^(app|vendor)/
        'test/css/test.css': /^test/
      order:
        before: []
        after: []

    templates:
      joinTo: 'js/app.js'

  server:
    path: \main.ls
    port: process.env.LISTEN or 8888

  plugins:
    after-brunch: [ 'kill -USR2 $PPID' ]
    stylus:
      plugins: ['nib']
