export default defineEventHandler ( async (event) => {
    const idPost = getRouterParam(event, 'id')
    const body = await readBody(event)
    if(!body.isAdmin && !body.isOwnPost) {
        throw createError({
            statusCode: 401,
            message: "You don't have rights to do this action."
        });
    }
    await pool.query(
        'UPDATE posts SET title = $1 , content = $2 WHERE id = $3', [body.title, body.content, idPost ]);
})