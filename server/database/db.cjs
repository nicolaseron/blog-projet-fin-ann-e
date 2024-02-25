const { Client } = require('pg');
require('dotenv').config({ path: __dirname + '/./../../.env' });

const client = new Client({
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: process.env.DB_DATABASE,
});

module.exports = {
    connect: () => client.connect(),
    query: (text, params) => client.query(text, params),
    end: () => client.end(),
};