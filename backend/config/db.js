const mongoose = require('mongoose');

mongoose.connect('mongodb+srv://liyana2003clt:<password>@cluster0.ekopw.mongodb.net/LH', {
    // useNewUrlParser: true,
    // useUnifiedTopology: true
}).then(() => console.log("MongoDB Connected Successfully"))
.catch(err => console.log("MongoDB Connection Failed", err));

module.exports = mongoose;
