var loopback    = require('loopback');
var boot        = require('loopback-boot');
var chalk       = require('chalk');
var moment      = require('moment');

var app = module.exports = loopback();

require('coffee-script').register();

app.start = function() {
  // start the web server
  return app.listen(function() {
    app.emit('started');
    var baseUrl = app.get('url').replace(/\/$/, '');
    console.log("[" + (chalk.gray(moment().format('HH:mm:ss'))) + "] " + (chalk.green('[express] Translation Manager backend is running at')) + " " + (chalk.blue(baseUrl)));

    if (app.get('loopback-component-explorer')) {
      var explorerPath = app.get('loopback-component-explorer').mountPath;
      console.log("[" + (chalk.gray(moment().format('HH:mm:ss'))) + "] " + (chalk.green('[swagger] Swagger is accessible at %s%s')), chalk.blue(baseUrl), chalk.blue(explorerPath));
    }
  });
};

// Bootstrap the application, configure models, datasources and middleware.
// Sub-apps like REST API are mounted via boot scripts.
boot(app, __dirname, function(err) {
  if (err) throw err;

  // start the server if `$ node server.js`
  if (require.main === module)
    app.start();
});
