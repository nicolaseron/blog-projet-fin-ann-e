import {
    S3Client,
    PutObjectCommand,
} from "@aws-sdk/client-s3";

export default defineEventHandler(async (event) => {

    const s3Client = new S3Client({});

    interface MyData {
        imgType?: string;
        imgData?: string | Buffer;
        title?: string;
        content?: string;
        idProfil?:string;
        tags?: string[] | undefined
    }

    try {
        const body = await readMultipartFormData(event)
        const data: MyData = {}
        if (body) {
            data.imgType = body[0].type
            data.imgData = body[0].data
            data.title = body[1].data.toString()
            data.content = body[2].data.toString()
            data.idProfil = body[4].data.toString()
            data.tags = []
            body.forEach((el) => {
                if (!data.tags) {
                    return;
                }
                switch (el.name) {
                    case "tech" :
                        data.tags.push(el.name);
                        break;
                    case "sante" :
                        data.tags.push(el.name);
                        break;
                    case "politique" :
                        data.tags.push(el.name);
                        break;
                    case "mode" :
                        data.tags.push(el.name);
                        break;
                }
            })
        }
        const insertPost =
            "INSERT INTO posts (id_profil, title, content) VALUES ($1, $2, $3) RETURNING id";
        const insertQueryPost = await client.query(insertPost, [data.idProfil, data.title, data.content]);

        const idPost = insertQueryPost.rows[0].id;

        const insertTags = "INSERT INTO intermediary_tags_posts VALUES ($1 , $2)"
        const tagsArray: number[] = [];
        if (data.tags && data.tags.length > 0) {
            for (const el of data.tags) {
                const idTag = await client.query(`SELECT id
                                                  FROM tags
                                                  WHERE name = '${el}'`);
                tagsArray.push(idTag.rows[0].id);
            }
            tagsArray.sort();
        }
        await client.query(insertTags, [idPost, `{${tagsArray}}`]);

        const keyImg = `image_post_${idPost}`
        const params = {
            Bucket: process.env.AWS_BUCKET_NAME,
            Key: keyImg,
            Body: data.imgData,
            Region: process.env.AWS_REGION,
            ContentType: data.imgType
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
