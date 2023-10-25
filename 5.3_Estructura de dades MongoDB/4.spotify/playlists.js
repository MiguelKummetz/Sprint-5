const Playlists = new Schema({
    playlist_id: ObjectId,
    name: String,
    total_sogs: Number,
    creation_date: Date,
    created_by: user_id,
    is_deleted: Boolean,
    delete_date: Date,
    songs: [{
        added_by: user_id,
        song_id: ObjectId,
        title: String,
        duration: Number,
        reproductions: Number,
        times_played: Number,
        liked_by: [user_id]
    }]

})