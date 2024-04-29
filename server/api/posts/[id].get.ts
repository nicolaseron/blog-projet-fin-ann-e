import {Post} from '../models/Post'
import {QueryResult} from "pg";

export default defineEventHandler(async (event) => {
    try {
        const idPost = getRouterParam(event, 'id');
        const selectPost: QueryResult<Post> =
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
    } catch (error) {
        console.log("Erreur lors de l'éxécution de la requête post.get", error);
        throw new Error('Error executing query');
    }
})