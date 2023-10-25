const Users = new Schema({
    user_id: ObjectId,
    email: String,
    password: String,
    username: String,
    birthdate: Date,
    gender: String,
    address:{
        coutry: String,
        postal_code: String,
    },
    channel:{
        channel_id: ObjectId,
        name: String,
        creation_date: Date,
        description: String,
        videos: [videos_id],
        subscriptions: [channel_id]
    },
    playlists:[{
        playlist_id: ObjectId,
        name: String,
        creation_date: Date,
        is_private: Boolean,
        videos: [videos_id]
    }]
})