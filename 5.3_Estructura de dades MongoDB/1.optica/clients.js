const Clients = new Schema({
  client_id: ObjectId,
  name: String,
  email: String,
  registration_date: Date,
  postal_adress: String,
  telephone: [String],
  recomendation: client_id,
  orders: {
    order_id: ObjectId,
    items: [{
      item_id: ObjectId,
      supplier: String,
      brand: String,
      price: Number,
      frame_type: String,
      frame_color: String,
      graduation_L: String,
      graduation_R: String,
      glass_color: String
    }],
    total_price: Number,
    sale_date: Date,
    sold_by: String
  }
})