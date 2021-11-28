function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    apiUrl: 'http://localhost:3000/api/'
  }
  karate.log('env:', env)
  if (env == 'dev') {
    config.userEmail = 'test@test.hu'
    config.userPassword = 'test'
  } else if (env == 'qa') {
    config.userEmail = 'test2@test.hu'
    config.userPassword = 'test2'
  }
  else {
    karate.log('No matching environment found')
  }
  return config;
}