import bcrypt from "bcrypt";

export default defineEventHandler(async event => {
    const response = await readFormData(event)
    const userEmail = response.get('email')
    const userPassword = response.get('password')
    const userFirstName = response.get('firstname')
    const userLastName = response.get('lastName')
    const userPseudo = response.get('pseudo')
    const searchMailIntoDB = await client.query(`SELECT mail
                                                 from profil
                                                 where mail = '${userEmail}'`)
    const isEmailExist = searchMailIntoDB.rows[0]
    const searchPseudoIntoDB = await client.query(`SELECT pseudo
                                                   from profil
                                                   where pseudo = '${userPseudo}'`)
    const isPseudoExist = searchPseudoIntoDB.rows[0]
    if (isEmailExist) {
        throw createError({
            statusCode: 409,
            statusMessage: "emailExist"
        })
    } else if (isPseudoExist) {
        throw createError({
            statusCode: 409,
            statusMessage: "pseudoExist"
        })
    } else {
        // @ts-ignore
        bcrypt.hash(userPassword, 10, async function (err:any, hash:string) {
            if (err) {
                throw createError({
                    statusCode: 400,
                    statusMessage: "Une erreure s'est produite"
                })
            } else {
                const insertProfil =
                    "INSERT INTO profil (first_name , last_name , mail , password , pseudo) VALUES ($1 , $2 , $3 , $4 , $5)"
                const insertIntoDB =
                    await client.query(insertProfil, [userFirstName, userLastName, userEmail, hash, userPseudo])
            }
        })
    }
})