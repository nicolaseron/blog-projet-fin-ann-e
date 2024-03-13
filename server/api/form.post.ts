import {
    S3Client,
    PutObjectCommand,
    GetObjectCommand,
} from "@aws-sdk/client-s3";
export default defineEventHandler(async (event) => {

    const s3Client = new S3Client({});
    interface MyData {
        imgType?: string;
        imgData?: string | Buffer;
        title?: string;
        content?: string;
    }

    try {
        const body = await readMultipartFormData(event)
        const data :MyData = {}
        if (body) {
            data.imgType = body[0].type
            data.imgData = body[0].data
            data.title = body[1].data.toString()
            data.content = body[2].data.toString()
        }
        const insertPost =
            "INSERT INTO posts (id_profil, title, content) VALUES ($1, $2, $3)";
        await client.query(insertPost, [1, data.title, data.content]);

        const queryIdPost = await client.query(
            `SELECT id
             FROM posts
             WHERE title = '${data.title}'
               AND content = '${data.content}'`
        );

        const idPost = queryIdPost.rows[0].id;

        const keyImg = `image_post_${idPost}`
        const params = {
            Bucket : process.env.AWS_BUCKET_NAME,
            Key : keyImg,
            Body : data.imgData,
            Region : process.env.AWS_REGION,
            ContentType : data.imgType
        }
        await s3Client.send(
            new PutObjectCommand({
                Bucket: params.Bucket,
                Key: params.Key,
                Body: params.Body,
                ContentType: params.ContentType,
            })
        );
        const url = `https://${params.Bucket}.s3.${params.Region}.amazonaws.com/${params.Key}`

        const insertImage = "INSERT INTO images (id_post, img_link) VALUES ($1, $2)";

        await client.query(insertImage, [idPost, url]);
    } catch (err) {
        console.error("Erreur lors de l'éxécution de la requête", err);
    }
});
