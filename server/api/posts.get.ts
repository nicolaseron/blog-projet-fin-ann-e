export default defineEventHandler(async () => {
    try {
        const result = await client.query('SELECT * FROM posts');
        return result.rows
    } catch (err) {
        console.error('Error executing query', err);
    }
})


