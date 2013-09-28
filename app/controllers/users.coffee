mongoose = require 'mongoose'

User = mongoose.model 'User'

exports.create = (req, res) ->
  user = new User
    first_name: req.body.firstname
    last_name: req.body.lastname
    email: req.body.email
  user.save (err, user) ->
    if not err
      res.send user

exports.get = (req, res) ->
  User.findOne _id:req.params.id, (err, user) ->
    res.send user

