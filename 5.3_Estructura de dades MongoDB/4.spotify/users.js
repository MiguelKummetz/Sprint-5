const Users = new Schema({
    user_id: ObjectId,
    name: String,
    email: String,
    password: String,
    birthdate: Date,
    gender: String,
    address:{
        coutry: String,
        postal_code: String,
    },
    is_premium: Boolean,
    subscription:{
        init_date: Date,
        re_date: Date,
        payment:{
            payment_id: ObjectId,
            order_num: Number,
            date: Date,
            total_import: Number
        },
        creditcard:{
            creditcard_id: ObjectId,
            number: Number,
            exp_month: Number,
            exp_year: Number,
            sec_code: Number,
        },
        paypal:{
            paypal_id: ObjectId,
            username: String
        }
    },
    Playlists: [playlist_id],
    songs_liked: [artist.album.song_id],
    albums_like: [artist.album_id],
    artist_following: [artist_id]
})