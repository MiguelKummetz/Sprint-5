const Coments = new Schema({
    coment_id: ObjectId,
    user: user_id,
    video: video_id,
    content: String,
    creation_date: Date,
    rating:[{
        user: user_id,
        like_dislike: Boolean,
    }],
    likes: Number,
    dislikes: Number,
    disliked_by: [user_id],
    liked_by: [user_id],
})