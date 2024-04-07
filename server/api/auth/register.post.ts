import bcrypt from "bcrypt";

export default defineEventHandler(async event => {
    const response = await readFormData(event);
    const userEmail = response.get('email');
    const userPassword = response.get('password');
    const userFirstName = response.get('firstname');
    const userLastName = response.get('lastName');
    const userPseudo = response.get('pseudo');

    const searchMailIntoDB = await client.query('SELECT mail FROM profil WHERE mail = $1', [userEmail]);
    const isEmailExist = searchMailIntoDB.rows[0];
    const searchPseudoIntoDB = await client.query('SELECT pseudo FROM profil WHERE pseudo = $1', [userPseudo]);
    const isPseudoExist = searchPseudoIntoDB.rows[0];

    if (isEmailExist) {
        throw createError({
            statusCode: 401,
            statusMessage: "emailExist"
        });
    } else if (isPseudoExist) {
        throw createError({
            statusCode: 401,
            statusMessage: "pseudoExist"
        });
    } else {
        // @ts-ignore
        bcrypt.hash(userPassword, 10, async function (err, hash) {
            if (err) {
                throw createError({
                    statusCode: 500,
                    statusMessage: "Une erreur s'est produite lors du hachage du mot de passe"
                });
            } else {
                try {
                    const insertProfil = "INSERT INTO profil (first_name, last_name, mail, password, pseudo) VALUES ($1, $2, $3, $4, $5)";
                    await client.query(insertProfil, [userFirstName, userLastName, userEmail, hash, userPseudo]);
                } catch (error) {
                    throw createError({
                        statusCode: 500,
                        statusMessage: "Une erreur s'est produite lors de l'insertion dans la base de données"
                    });
                }
            }
        });
    }
});