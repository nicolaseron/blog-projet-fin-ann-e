export default defineEventHandler(async (event) => {
    const body = await readBody(event)
    if (body.isAdmin) {
        await pool.query(`DELETE
                          FROM comments
                          WHERE id = ${body.idComment}`)
    } else {
        throw createError({
            statusCode: 401,
            message: "You don't have rights to do this action."
        });
    }
})