export default defineEventHandler(async () => {
    try {
        const result = await client.query(`
            SELECT posts.id, posts.title, posts.content ,images.img_link, images.id_post 
            FROM posts
            JOIN images on images.id_post = posts.id;
        `);
        return result.rows;
    } catch (err) {
        console.log("Erreur lors de l'éxécution de la requête post.get" , err);
        throw new Error('Error executing query');
    }
});
