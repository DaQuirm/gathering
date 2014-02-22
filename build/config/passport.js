var GoogleStrategy, mongoose;

mongoose = require('mongoose');

GoogleStrategy = require('passport-google').Strategy;

module.exports = function(passport) {
  passport.serializeUser(function(user, done) {
    return done(null, user);
  });
  passport.deserializeUser(function(obj, done) {
    return done(null, obj);
  });
  return passport.use(new GoogleStrategy({
    returnURL: 'http://localhost:3000/auth/google/return',
    realm: 'http://localhost:3000/'
  }, function(identifier, profile, done) {
    return done(null, profile);
  }));
};
