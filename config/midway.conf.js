basePath = '../';

files = [
  MOCHA,
  MOCHA_ADAPTER,
  './config/mocha.conf.js',

  //3rd Party Code
  './src/lib/angular.js',

  //App-specific Code
  './src/app/app.coffee',
  './src/config/*.coffee',
  './src/controllers/*.coffee',
  './src/directives/*.coffee',
  './src/filters/*.coffee',
  './src/services/*.coffee',

  //Test-Specific Code
  './node_modules/chai/chai.js',
  './test/lib/chai-should.js',
  './test/lib/chai-expect.js',
  './vendor/ngMidwayTester/Source/ngMidwayTester.js',

  //Test-Specs
  './test/midway/**/*.coffee'
];


port = 9202;
runnerPort = 9302;
captureTimeout = 5000;


shared = require(__dirname + "/shared.conf.js").shared
growl     = shared.colors;
colors    = shared.colors;
singleRun = shared.singleRun;
autoWatch = shared.autoWatch;
browsers  = shared.defaultBrowsers;
reporters = shared.defaultReporters;
proxies   = shared.defaultProxies;
