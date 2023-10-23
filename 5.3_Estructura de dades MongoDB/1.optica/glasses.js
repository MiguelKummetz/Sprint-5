const Glasses = new Schema({
    _id: ObjectId,
    supplier: String,
    brand: String,
    price: Number,
    frame_type: String,
    frame_color: String,
    graduation_L: String,
    graduation_R: String,
    glass_color: String
  })