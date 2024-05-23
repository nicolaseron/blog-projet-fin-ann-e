export default defineEventHandler( async (event) => {
    const body = await readBody(event)
    const insertComment = await pool.query(`
    INSERT INTO comments(id_post, id_user, comment) VALUES ($1,$2,$3)
    ` , [body.post , body.user , body.comment])
})