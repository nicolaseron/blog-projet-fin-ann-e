import {pool} from "~/server/utils/db-client";
import {MailerSend, EmailParams, Sender, Recipient} from "mailersend";

export default defineEventHandler(async (event) => {
    const response = await readFormData(event);
    const userEmail = response.get('email');
    const userPassword = response.get('password');
    const userFirstName = response.get('firstname');
    const userLastName = response.get('lastName');
    const userPseudo = response.get('pseudo');
    const code = response.get('code')

    const searchMailIntoDB = await pool.query('SELECT mail FROM profil WHERE mail = $1', [userEmail]);
    const email: string = searchMailIntoDB.rows[0];
    const searchPseudoIntoDB = await pool.query('SELECT pseudo FROM profil WHERE pseudo = $1', [userPseudo]);
    const pseudo: string = searchPseudoIntoDB.rows[0];

    if (email) {
        throw createError({
            statusCode: 401,
            statusMessage: "emailExist"
        });
    } else if (pseudo) {
        throw createError({
            statusCode: 401,
            statusMessage: "pseudoExist"
        });
    } else {
        const mailerSend = new MailerSend({
            apiKey: String(process.env.MAILERSEND_API_KEY),
        });

        const sentFrom = new Sender("MS_fAnJeA@trial-yzkq340opw24d796.mlsender.net", "coffee time");

        const recipients = [
            new Recipient(String(userEmail), "test")
        ];
        const emailParams = new EmailParams()
            .setFrom(sentFrom)
            .setTo(recipients)
            .setSubject("E-mail vérification Coffee Time")
            .setText(`Voici votre code de vérification pour l'inscription au blog Coffee Time : ${code}`);

        await mailerSend.email.send(emailParams)
    }

});
