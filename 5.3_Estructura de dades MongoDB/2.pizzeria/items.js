const Items = new Schema({
    _id: ObjectId,
    category: String,
    pizza_category: {
        _id: ObjectId,
        name: String,
    },
    name: String,
    description: String,
    picture: String,
    price: Number
  })