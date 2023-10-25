const Artists = new Schema({
    artist_id: ObjectId,
    name: String,
    image: String,
    releted_artist: [artist_id],
    followed_by: [user_id],
    albums:[{
        album_id: ObjectId,
        title: String,
        publication_date: Date,
        cover: String,
        liked_by: [user_id],
        songs: [{
            song_id: ObjectId,
            title: String,
            duration: Number,
            reproductions: Number,
            times_played: Number,
            liked_by: [user_id]
        }]
    }]
  })