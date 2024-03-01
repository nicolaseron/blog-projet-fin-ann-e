export default defineNitroPlugin(async (nitroApp: any) => {
    await connectToDatabase();

    nitroApp.hooks.hook('close', () => {
        disconnectFromDatabase();
    });
});
