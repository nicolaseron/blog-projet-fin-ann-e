import pg from "pg";

const config = useRuntimeConfig();
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
client.on('error', async err => {
    console.log("postgres error try to reconnect")
    await client.end()
    isConnected = false;
    await connectToDatabase()
});

export const disconnectFromDatabase = async () => {
    if (isConnected) {
        try {
            await client.end();
            isConnected = false
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
