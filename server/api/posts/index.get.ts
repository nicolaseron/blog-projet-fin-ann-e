export default defineEventHandler(async () => {
    try {
        const result = await client.query(`
            SELECT posts.id,
                   posts.title,
                   posts.content,
                   posts.tags,
                   images.img_link
            FROM posts
                     JOIN images on images.id_post = posts.id
            ORDER BY posts.id desc
        `);
        return result.rows;
    } catch (err) {
        console.log("Erreur lors de l'éxécution de la requête post.get" , err);
        throw new Error('Error executing query');
    }
});