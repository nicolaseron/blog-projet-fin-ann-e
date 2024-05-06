import {
    S3Client,
    PutObjectCommand,
} from "@aws-sdk/client-s3";
import jwt from "jsonwebtoken";
import {pool} from "~/server/utils/db-client";

export default defineEventHandler(async (event) => {

    const s3Client = new S3Client({});

    interface Data {
        imgType?: string;
        imgData?: string | Buffer;
        title?: string;
        content?: string;
        idProfil?: string;
        tags?: string
    }

    try {
        const body = await readMultipartFormData(event)
        const token = event.headers.get('Authorization')
        if (!token) {
            throw createError({
                statusCode: 401,
                message: "Le Token n'est pas présent !"
            });
        }
        const decodedToken = jwt.verify(token.split(' ')[1], 'fsuhviuuzihtaivinviuifnccuih46461s4g1s94vs9g');
        if (!decodedToken) {
            throw createError({
                statusCode: 401,
                message:"Le Token est invalide !"
            })
        }
        const data: Data = {}
        if (body) {
            data.imgType = body[0].type
            data.imgData = body[0].data
            data.title = body[1].data.toString()
            data.content = body[2].data.toString()
            data.tags = body[3].data.toString()
            data.idProfil = body[4].data.toString()
        }
        const insertPost =
            "INSERT INTO posts (id_profil, title, content,tags) VALUES ($1, $2, $3, $4) RETURNING id";
        const insertQueryPost = await pool.query(insertPost,
            [data.idProfil, data.title, data.content, data.tags]);

        const idPost = insertQueryPost.rows[0].id;

        const keyImg = `image_post_${idPost}`
        const params = {
            Bucket: process.env.AWS_BUCKET_NAME,
            Key: keyImg,
            Body: data.imgData,
            Region: process.env.AWS_REGION,
            ContentType: data.imgType
        };
        await s3Client.send(
            new PutObjectCommand({
                Bucket: params.Bucket,
                Key: params.Key,
                Body: params.Body,
                ContentType: params.ContentType,
            })
        );
        const url = `https://${params.Bucket}.s3.${params.Region}.amazonaws.com/${params.Key}`;
        const insertImage = "INSERT INTO images (id_post, img_link) VALUES ($1, $2)";
        await pool.query(insertImage, [idPost, url]);
    } catch (err) {
        console.error("Erreur lors de l'éxécution de la requête", err);
    }
});