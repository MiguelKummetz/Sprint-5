const Stores = new Schema({
    store_id: ObjectId,
    name: String,
    telephone: String,
    address: {
        street: String,
        number: String,
        city: String,
        postal_code: String,
        province: String,
    }
  })