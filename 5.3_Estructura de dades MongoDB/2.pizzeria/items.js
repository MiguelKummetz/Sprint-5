const Items = new Schema({
    item_id: ObjectId,
    category: String,
    pizza_category: {
        category_id: ObjectId,
        name: String,
    },
    name: String,
    description: String,
    picture: String,
    price: Number
  })