import pg from "pg";

const config = useRuntimeConfig();
export const pool = new pg.Pool({
    connectionString: config.dbUrl,
    ssl: {
        rejectUnauthorized: false,
    },
});
