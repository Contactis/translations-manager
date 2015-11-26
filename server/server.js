var loopback    = require('loopback');
var boot        = require('loopback-boot');
var chalk       = require('chalk');
var moment      = require('moment');
var argv        = require('yargs').argv;
var bodyParser  = require('body-parser');

var app = module.exports = loopback();

require('coffee-script').register();


app.use(loopback.compress());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.text());

app.start = function() {
  // start the web server
  return app.listen(function() {
    app.emit('started');

      if (typeof argv.silent === 'undefined') {
          var baseUrl = app.get('url').replace(/\/$/, '');

          if (app.get('loopback-component-explorer')) {
            var explorerPath = app.get('loopback-component-explorer').mountPath;
            console.log('[' + (chalk.gray(moment().format('HH:mm:ss'))) + '] ' + (chalk.green('[swagger] Swagger is accessible at %s%s')), chalk.blue(baseUrl), chalk.blue(explorerPath));
          }

          console.log('[' + (chalk.gray(moment().format('HH:mm:ss'))) + '] ' + (chalk.green('[express] Translation Manager backend is running at')) + ' ' + (chalk.blue(baseUrl)));
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
