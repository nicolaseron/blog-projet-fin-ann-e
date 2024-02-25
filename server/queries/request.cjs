const db = require("../database/db.cjs");

async function getAllPost() {
    try {
        await db.connect();
        const result = await db.query("SELECT * FROM profil");
        console.log(result.rows);
    } catch (error) {
        console.error('Error retrieving posts:', error);
    } finally {
        await db.end();
    }
}

module.exports = {
    getAllPost,
}
