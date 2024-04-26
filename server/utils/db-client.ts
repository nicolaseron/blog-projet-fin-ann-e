import pg from "pg";

const config = useRuntimeConfig();
let dbClient;
export const client = new pg.Client({
    connectionString: config.dbUrl,
    ssl: {
        rejectUnauthorized: false,
    },
});

let isConnected = false;

export const connectToDatabase = async () => {
    if (!isConnected) {
        try {
            await client.connect();
            isConnected = !isConnected;
        } catch (err) {
            console.log("Error connecting to the database", err);
        }
    }
};
const reconnectToDb = async () => {
    dbClient = null;
    dbClient = await connectToDatabase();
};
client.on('error', err => {
    console.log("postgres error try to reconnect")
    reconnectToDb()
});

export const disconnectFromDatabase = async () => {
    if (isConnected) {
        try {
            await client.end();
            isConnected = !isConnected;
        } catch (err) {
            console.log("Error disconnecting from the database", err);
        }
    }
};

export default {
    client,
    connectToDatabase,
    disconnectFromDatabase,
};
