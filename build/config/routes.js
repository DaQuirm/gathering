module.exports = function(app, passport) {
  var index, register, restricted, users;
  index = require('../app/controllers/index');
  app.get('/', index.render);
  register = require('../app/controllers/register');
  app.get('/register', register.render);
  app.get('/auth/google', passport.authenticate('google'));
  app.get('/auth/google/return', passport.authenticate('google', {
    successRedirect: '/register',
    failureRedirect: '/error'
  }));
  users = require('../app/controllers/users');
  app.post('/users', users.create);
  app.get('/users/:id', users.get);
  restricted = require('../app/controllers/restricted');
  return app.get('/restricted', restricted.test);
};
