// https://nuxt.com/docs/api/configuration/nuxt-config

export default defineNuxtConfig({
    devtools: {enabled: true},
    app: {
        pageTransition: {name: 'page', mode: 'out-in'}
    },
    css: ["~/assets/css/main.css", "~/assets/css/base.css", "~/assets/css/icon.css"],
    modules: ["@nuxtjs/tailwindcss", '@nuxt/image', '@sidebase/nuxt-auth', "nuxt-mailer"],
    build: {
        transpile: ['jsonwebtoken']
    },
    mail: {
        smtp: {
            host: "smtp.example.com",
            port: 587,
            secure: true,
        },
    },
    runtimeConfig: {
        dbUrl: process.env.DB_URL,
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
});