export interface Post {
    id : number,
    title : string,
    content : string,
    id_profil : number,
    tags : string,
    created_date : string,
    modified_date : string | null,
    images : string,
    pseudo : string
}