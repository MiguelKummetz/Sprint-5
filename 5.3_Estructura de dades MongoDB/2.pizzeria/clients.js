const Clients = new Schema({
    client_id: ObjectId,
    name: String,
    surname: String,
    telephone: String,
    address: {
        street: String,
        number: String,
        floor: String,
        door: String,
        city: String,
        postal_code: String,
        province: String,
    },
    orders: {
        order_id: ObjectId,
        type: String,
        time: Date,
        items: [{
          category: String,
          name: String,
          description: String,
          quantity: String,
          price: Number,
        }],
        total_price: Number,
        store: String
      }
  })