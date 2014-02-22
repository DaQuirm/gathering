var User, mongoose;

mongoose = require('mongoose');

User = mongoose.model('User');

exports.create = function(req, res) {
  var user;
  user = new User({
    first_name: req.body.firstname,
    last_name: req.body.lastname,
    email: req.body.email
  });
  return user.save(function(err, user) {
    if (!err) {
      return res.send(user);
    }
  });
};

exports.get = function(req, res) {
  return User.findOne({
    _id: req.params.id
  }, function(err, user) {
    return res.send(user);
  });
};
