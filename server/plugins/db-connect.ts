export default defineNitroPlugin(async (nitroApp: any) => {
    await pool.connect()

    nitroApp.hooks.hook('close', async () => {
        await pool.end();
    });
});
