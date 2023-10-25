const Suppliers = new Schema({
    supplier_id: ObjectId,
    name: String,
    nif: String,
    address: {
      street: String,
      number: String,
      floor: String,
      door: String,
      city: String,
      postal_code: String,
      country: String,
    },
    telephone: [String],
    fax: [String],
    brands: [String] 
  })