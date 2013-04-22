basePath = '../';

files = [
  ANGULAR_SCENARIO,
  ANGULAR_SCENARIO_ADAPTER,
  //tests
  './test/e2e/**/*.coffee'
];

port = 9203;
runnerPort = 9303;
captureTimeout = 5000;

shared = require(__dirname + "/shared.conf.js").shared
growl     = shared.colors;
colors    = shared.colors;
singleRun = shared.singleRun;
autoWatch = shared.autoWatch;
browsers  = shared.defaultBrowsers;
reporters = shared.defaultReporters;
proxies = {
  '/': 'http://localhost:8100/'
};
