import jwt from 'jsonwebtoken';

const refreshTokens: Record<number, Record<string, any>> = {}
export const SECRET = 'dummy'
export default defineEventHandler(async event => {
    const response = await readBody(event)
    const correspondingMailPassword =
        await client.query(`SELECT id
                            FROM profil
                            WHERE mail = '${response.email}'
                              AND password = '${response.password}';
        `)
    const idProfil = correspondingMailPassword.rows[0]
    if (idProfil.id) {
        // const expiresIn = "15"
        const profil = await client.query(`SELECT first_name, last_name, pseudo, bio
                                           FROM profil
                                           WHERE id = ${idProfil.id}`)
        const profilData = profil.rows[0]
        response.firstName = profilData.first_name
        response.lastName = profilData.last_name
        response.pseudo = profilData.pseudo
        response.bio = profilData.bio
        const refreshToken = Math.floor(Math.random() * (1000000000000000 - 1 + 1)) + 1;
        const accessToken = jwt.sign({response, scope: ['test', 'user']}, SECRET)
        refreshTokens[refreshToken] = {
            accessToken,
            profilData
        }
        return {
            token: {
                accessToken,
                refreshToken
            }
        }
    } else {
        throw createError({
            statusCode: 404,
            statusMessage: "invalidPassword"
        })
    }
})