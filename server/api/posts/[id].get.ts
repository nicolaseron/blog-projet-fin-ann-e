export default defineEventHandler(async (event) => {
    const idPost = getRouterParam(event, 'id')
    const selectPost =
        await client.query(
            `SELECT posts.id,
                    posts.title,
                    posts.content,
                    posts.id_profil,
                    posts.created_date,
                    posts.modified_date,
                    images.img_link,
                    intermediary_tags_posts.id_tags
             FROM posts
                      JOIN images on images.id_post = posts.id
                      JOIN intermediary_tags_posts ON intermediary_tags_posts.id_posts = posts.id
             WHERE posts.id = ${idPost}
            `)
    return selectPost.rows[0]
})