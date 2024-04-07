import jwt from 'jsonwebtoken';
import bcrypt from "bcrypt";

const refreshTokens: Record<number, Record<string, any>> = {}
export const SECRET = 'dummy'
export default defineEventHandler(async event => {
    const response = await readBody(event)
    const selectProfil = await client.query(`SELECT password, id
                                             from profil
                                             where mail = '${response.email}'`)
    const hash = selectProfil.rows[0];
    const result = await new Promise<boolean>((resolve, reject) => {
        bcrypt.compare(response.password, hash.password, (err, result) => {
            if (err || !result) {
                reject(err);
            } else {
                resolve(result);
            }
        });
    });

    if (!result) {
        throw createError({
            statusCode: 400,
            statusMessage: "Invalid password"
        });
    }

    const profil = await client.query(`SELECT id, first_name, last_name, pseudo, bio
                                       FROM profil
                                       WHERE id = ${selectProfil.rows[0].id}`)
    const profilData = profil.rows[0]
    response.id = profilData.id
    response.firstName = profilData.first_name
    response.lastName = profilData.last_name
    response.pseudo = profilData.pseudo
    response.bio = profilData.bio
    const refreshToken = Math.floor(Math.random() * (1000000000000000 - 1 + 1)) + 1;
    const accessToken = jwt.sign({response, scope: []}, SECRET)
    refreshTokens[refreshToken] = {
        accessToken,
        profilData
    }
    return {
        token: {
            accessToken,
            refreshToken
        }
    };
});
