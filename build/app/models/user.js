var mongoose, user_schema;

mongoose = require('mongoose');

user_schema = mongoose.Schema({
  first_name: String,
  last_name: String,
  email: String
});

mongoose.model('User', user_schema);
