import {pool} from "~/server/utils/db-client";
import bcrypt from "bcrypt";

export default defineEventHandler(async (event) => {
    const response = await readFormData(event);
    const userEmail = response.get('email');
    const userPassword = response.get('password');
    const userFirstName = response.get('firstname');
    const userLastName = response.get('lastName');
    const userPseudo = response.get('pseudo');
    const code = response.get('code');
    bcrypt.hash(String(userPassword), 10, async function (err, hash) {
        if (err) {
            throw createError({
                statusCode: 500,
                statusMessage: "Une erreur s'est produite lors du hachage du mot de passe"
            });
        }
        const insertProfil = "INSERT INTO profil (first_name, last_name, mail, password, pseudo) VALUES ($1, $2, $3, $4, $5)";
        await pool.query(insertProfil, [userFirstName, userLastName, userEmail, hash, userPseudo]);
    })
})
