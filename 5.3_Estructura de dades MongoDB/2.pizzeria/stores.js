const Stores = new Schema({
    _id: ObjectId,
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