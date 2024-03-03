export default defineEventHandler(async (event) => {
    try {
        const body = await readBody(event);
        const query = 'INSERT INTO posts (id_profil, title, content) VALUES ($1,$2,$3)'
        client.query(query, [1, body.title, body.content])
    } catch (err) {
        console.error('Error executing query', err);
    }
})
