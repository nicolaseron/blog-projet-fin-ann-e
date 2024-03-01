import pg from 'pg';

const config = useRuntimeConfig();

export const client = new pg.Client({
    connectionString: config.dbUrl,
});

let isConnected = false;

export const connectToDatabase = async () => {
    if (!isConnected) {
        try {
            await client.connect();
            isConnected = !isConnected
        } catch (err) {
            console.log('Error connecting to the database', err);
        }
    }
};

export const disconnectFromDatabase = async () => {
    if (isConnected) {
        try {
            await client.end();
            isConnected = !isConnected
        } catch (err) {
            console.log('Error disconnecting from the database', err);
        }
    }
};

export default {
    client,
    connectToDatabase,
    disconnectFromDatabase
}