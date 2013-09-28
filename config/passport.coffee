mongoose       = require 'mongoose'
GoogleStrategy = require('passport-google').Strategy

module.exports = (passport) ->

    passport.serializeUser (user, done) ->
      done null, user

    passport.deserializeUser (obj, done) ->
      done null, obj

    passport.use new GoogleStrategy {
        returnURL: 'http://localhost:3000/auth/google/return'
        realm: 'http://localhost:3000/'
      },
      (identifier, profile, done) ->
        done null, profile
