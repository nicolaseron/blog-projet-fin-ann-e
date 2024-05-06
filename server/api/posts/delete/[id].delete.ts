import jwt from "jsonwebtoken";

export default defineEventHandler(async (event) => {
    const idPost = getRouterParam(event, 'id')
    const token = event.headers.get('Authorization')
    if (!token) {
        throw createError({
            statusCode: 401,
            message: "Invalid Token !"
        });
    }
    const decodedToken = jwt.verify(token.split(' ')[1], 'fsuhviuuzihtaivinviuifnccuih46461s4g1s94vs9g');
    if (!decodedToken) {
        throw createError({
            statusCode: 401,
            message:"Le Token est invalide !"
        })
    }
    await pool.query('DELETE FROM images WHERE id_post = $1', [idPost])
    await pool.query('DELETE FROM posts WHERE id = $1', [idPost])
})
