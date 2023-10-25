const Videos = new Schema({
    video_id: ObjectId,
    channel: channel_id,
    title: String,
    size: Number,
    file_name: String,
    duration: Number,
    reproductions: Number,
    thumbnail: String,
    description: String,
    creation_date: Date,
    is_private: Boolean,
    is_ocult: Boolean,
    tags:[{
        tag_id: ObjectId,
        name: String
    }],
    rating:[{
        user: user_id,
        like_dislike: Boolean,
    }],
    likes: Number,
    dislikes: Number,
    disliked_by: [user_id],
    liked_by: [user_id],
})