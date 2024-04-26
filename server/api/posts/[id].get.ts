export default defineEventHandler(async (event) => {
    const idPost = getRouterParam(event, 'id');
    const selectPost =
        await client.query(
            `
                SELECT posts.id,
                       posts.title,
                       posts.content,
                       posts.id_profil,
                       posts.tags,
                       posts.created_date,
                       posts.modified_date,
                       images.img_link,
                       profil.pseudo
                FROM posts
                         JOIN images on images.id_post = posts.id
                         JOIN profil ON profil.id = posts.id_profil
                WHERE posts.id = ${idPost}
            `);
    return selectPost.rows[0];
})