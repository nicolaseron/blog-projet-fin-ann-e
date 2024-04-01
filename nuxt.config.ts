// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
    devtools: {enabled: true},
    css: ["~/assets/css/main.css", "~/assets/css/base.css"],
    modules: ["@nuxtjs/tailwindcss", '@nuxt/image', '@sidebase/nuxt-auth'],
    build: {
        transpile: ['jsonwebtoken']
    },
    auth: {
        provider: {
            type: "local",
            pages: {
                login: "/connexion"
            },
            token: {
                signInResponseTokenPointer: '/token/accessToken'
            },
        },
    },
    postcss: {
        plugins: {
            tailwindcss: {},
            autoprefixer: {},
        },
    },
    runtimeConfig: {
        dbUrl: process.env.DB_URL,
    },
});
