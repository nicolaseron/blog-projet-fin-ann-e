PGDMP  1    *                |           blog    16.1    16.1 $    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16424    blog    DATABASE     p   CREATE DATABASE blog WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE blog;
                postgres    false            �            1259    16425    comments    TABLE     �   CREATE TABLE public.comments (
    id integer NOT NULL,
    id_post bigint NOT NULL,
    id_user bigint NOT NULL,
    date date DEFAULT now() NOT NULL
);
    DROP TABLE public.comments;
       public         heap    postgres    false            �            1259    16429    comments_id_seq    SEQUENCE     �   CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.comments_id_seq;
       public          postgres    false    215            �           0    0    comments_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;
          public          postgres    false    216            �            1259    16430    images    TABLE     ~   CREATE TABLE public.images (
    id integer NOT NULL,
    id_post bigint NOT NULL,
    img_link character varying NOT NULL
);
    DROP TABLE public.images;
       public         heap    postgres    false            �            1259    16435    images_id_seq    SEQUENCE     �   CREATE SEQUENCE public.images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.images_id_seq;
       public          postgres    false    217            �           0    0    images_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.images_id_seq OWNED BY public.images.id;
          public          postgres    false    218            �            1259    16441    profil    TABLE       CREATE TABLE public.profil (
    id integer NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    mail character varying NOT NULL,
    password character varying NOT NULL,
    pseudo character varying NOT NULL
);
    DROP TABLE public.profil;
       public         heap    postgres    false            �            1259    16446    person_id_seq    SEQUENCE     �   CREATE SEQUENCE public.person_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.person_id_seq;
       public          postgres    false    219            �           0    0    person_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.person_id_seq OWNED BY public.profil.id;
          public          postgres    false    220            �            1259    16447    posts    TABLE       CREATE TABLE public.posts (
    id integer NOT NULL,
    id_profil bigint NOT NULL,
    title character varying NOT NULL,
    content character varying NOT NULL,
    created_date date DEFAULT now() NOT NULL,
    modified_date date,
    tags character varying NOT NULL
);
    DROP TABLE public.posts;
       public         heap    postgres    false            �            1259    16453    posts_id_seq    SEQUENCE     �   CREATE SEQUENCE public.posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.posts_id_seq;
       public          postgres    false    221            �           0    0    posts_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;
          public          postgres    false    222            ;           2604    16460    comments id    DEFAULT     j   ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);
 :   ALTER TABLE public.comments ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215            =           2604    16461 	   images id    DEFAULT     f   ALTER TABLE ONLY public.images ALTER COLUMN id SET DEFAULT nextval('public.images_id_seq'::regclass);
 8   ALTER TABLE public.images ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217            ?           2604    16462    posts id    DEFAULT     d   ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);
 7   ALTER TABLE public.posts ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    221            >           2604    16463 	   profil id    DEFAULT     f   ALTER TABLE ONLY public.profil ALTER COLUMN id SET DEFAULT nextval('public.person_id_seq'::regclass);
 8   ALTER TABLE public.profil ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219            �          0    16425    comments 
   TABLE DATA           >   COPY public.comments (id, id_post, id_user, date) FROM stdin;
    public          postgres    false    215   �&       �          0    16430    images 
   TABLE DATA           7   COPY public.images (id, id_post, img_link) FROM stdin;
    public          postgres    false    217   '       �          0    16447    posts 
   TABLE DATA           a   COPY public.posts (id, id_profil, title, content, created_date, modified_date, tags) FROM stdin;
    public          postgres    false    221   �'       �          0    16441    profil 
   TABLE DATA           S   COPY public.profil (id, first_name, last_name, mail, password, pseudo) FROM stdin;
    public          postgres    false    219   r4       �           0    0    comments_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.comments_id_seq', 1, false);
          public          postgres    false    216            �           0    0    images_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.images_id_seq', 166, true);
          public          postgres    false    218            �           0    0    person_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.person_id_seq', 35, true);
          public          postgres    false    220            �           0    0    posts_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.posts_id_seq', 337, true);
          public          postgres    false    222            B           2606    16466    comments comments_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_pkey;
       public            postgres    false    215            D           2606    16468    images images_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.images DROP CONSTRAINT images_pkey;
       public            postgres    false    217            H           2606    16470    posts posts_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_pkey;
       public            postgres    false    221            F           2606    16472    profil profil_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.profil
    ADD CONSTRAINT profil_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.profil DROP CONSTRAINT profil_pkey;
       public            postgres    false    219            I           2606    16480    comments comments_id_post_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_id_post_fkey FOREIGN KEY (id_post) REFERENCES public.posts(id) NOT VALID;
 H   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_id_post_fkey;
       public          postgres    false    4168    221    215            J           2606    16475    comments comments_id_user_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_id_user_fkey FOREIGN KEY (id_user) REFERENCES public.profil(id) NOT VALID;
 H   ALTER TABLE ONLY public.comments DROP CONSTRAINT comments_id_user_fkey;
       public          postgres    false    215    4166    219            K           2606    16485    images images_id_post_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.images
    ADD CONSTRAINT images_id_post_fkey FOREIGN KEY (id_post) REFERENCES public.posts(id) NOT VALID;
 D   ALTER TABLE ONLY public.images DROP CONSTRAINT images_id_post_fkey;
       public          postgres    false    217    4168    221            L           2606    16495    posts posts_id_profil_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_id_profil_fkey FOREIGN KEY (id_profil) REFERENCES public.profil(id) NOT VALID;
 D   ALTER TABLE ONLY public.posts DROP CONSTRAINT posts_id_profil_fkey;
       public          postgres    false    4166    221    219            �      x������ � �      �   h   x���A
� @�us�Fj�Eg	�D*H'#��t�����u{��L�9li=y+Gd�t�O���^.����p�X�?�Ա��UǪ���S�7:f�P�a�      �   �  x��Y˒�]K_�����A D8�p�D r8���3K��a��k{�W��ߘ?�K|��̪���,��|�<��sO&�o߾q�΍'v7v}a�F=���ETg6m��&&�]�����^};�����S�Ҩ����'/�0D��J[���6{3���nM4�?3a���t[g_e����܏J��z���j�.|�����Wz5\(=�鋨��}�_����%�c��`�Q�`��;��w���woN�.� �C;`,���_��ҙWc�ymt���k�&8���O�`Ǆ�tR�vjk��a����n����	'=�N'�]<U_���d�R��w�9~�u��7Ǧ�Ao��l�}���p�NYw�)�{a�O��\���Þ6�����������E��w~�zt��#��`v�%�����
~�P!fj����O��K�"r�9�`����F͏kbZ*���~RT?~�T�,����t���t���9�����=��G�ۜƜ���Z�C~<X��q�)�ރ����$�o��C٤�u��|�=�X�۽������w+b�8�$��G��[ǿ��	��8F��~�L�;iD&r�#V*�� �PL�$$w)��K�;�2����i�#
�?�����ӓ[wNn}v���	2s���OE�KW�w!J����F=�2A�P'U��u��W�v�.���������ZE��cF��Ȅ����z�G����Pr:���_šF��f� <�����5��t�9�黼�'�Q�F� ��5��u��:��G�N�ϑCFL�&@	�N;{�:����4��\=�.�ΤYqd.�����5��>�c�1���ub����9�|a�'�l�@�"��	#� a>p�����X�$K���c. ��5jr!Wx�����^!XD�>�������ˤ�ZY�N�~M��K��EdO� �*KY��é����e�C)AE�qvm%4aC�Vh<.����,peD_B[��F���JSP�v/șNR�3�ƣ�T��W��P$lI&�'����e�궚�^���_c��X���`�oRS��qa��D���RG�K���sa�X7[{�kA7�����FJ��?��_���a���!|��A��1�����2�$��ɺ}��$_��W'>�XY��wG��d����5R��r�݌����(��eg���'O�p�90��gd��tB�E���4gl��n�T-G�c�=��2�����A����+6�r����𼀍6�K��,�D�,K���
�*э�v� ��6�q 4pc:�����Z-�S�~��;$ࡉ��� �z�3kv�A1�ۋR��PuO��d��l�ʦܗ�&y�T]��"�	Gئ,ȑ\/:�J#P����'�R�	�4xf����QE���woQ���в�:7�ئ,:�h�纀,��!�_�4g(�*F������2V�aױh��e�|��WR��f2��pɺ=�+Fa;ˡ:`�ױ�~��A$ex�M(y�(v�������.G�ye�)R���X!�p�A'gE�vS��Vj�[�H��1�@�>D�GA�e�����[�9(��0�
�x��0(+�)�׏���r֝gu93\�I���z��.������Z� ͞������ ��R��|�W~D�#F々]��M�4��kv�a��;�["W��&U��v#w'S��+z36x�1�'��+��箉l�8�Q����Y���4J֭�\��pv�3�=O�凚�.��I�(v�'a�_e$�u�VX�&u�u�
#��2��<�öm�z�j5G"[�h�}���<�@�1�-lv#� ԣ*k��"Lz>�^j<X�w�))�!���Yj����,��4,����w)P�`n�%��j(!u')�^9�u�����Y��pK�;�T٪�bj�Ї�����h��?b��bpUzQU�g��0�Q<��\ے��n�+�8%����&�?i;5vD�0�GKi��.7��;1N.8���@W��(C�}�N�!\�i�D���-ǔ1I�(cqK+,)�������՝�p�+�8:Di7|����5,I���0&KM9�F-�[���"��E����L;��H=��\=(ȕ
|P<��-���JL�򼡙"�d�bҞ��[+��:�[�N�t�Lq�]��r�����C�,<���-�Z���Ԁ[�J�hEB�S���t�����@��<������Kf^H����e5��Y�L���-�G���[��c���s��w�A��DRACr4�[K� ( ����B0����ʠtv֒k��-�-�m��;���g�m�W]���{W����%ҫ�cm��m}�p�5
���MítL6,����$-K����n`�v�}����t�n�/Hq�-;
M&J�����7Ç�N������2�� �0r��[D��Z��kt��AM%=�h�
�u����������X���C� |�U�K���a���ps���q�V���IŘ�z��+��kʁ�B{�M{(���L{-��.�P��8�z]l�ԿsҼ�pk���#�n	I���y/1�ʔ�Xc��E�]����,ʾ�������L��?`ý��U3E��yzoc�|��θ�܃�p[I�NUG����Qw}:{�K�{������~����&�"$̆��Q�"&� >�u�7�Ό��:�����<x��n������9J_H����L����� y�!�q#���2�9�`0�~�v�Dy�jFs-c4L-����EP���.�y�6�����l��̱�o���Oz3@ΊZƄ�TsZ�g����l3�۽͘0!%c�er��z�\���/��"�a�m	���.���}��(�/�bk�i
���v�9[�d_��5�5�H귵:�mR�"���`{\ݗ��(ny~�k�c�h��4�ʃr����)K��W; ,�TW��L`����9_~̑����AGŊ���r�Ś&��z���|�`p�����\�X��������8�_< HB"7�Ц>���HS�*h�hy�Fh��:����(�`���-�}�C����*�Qe~%}8?��r�Ź� ΆU6δlԺ޴G��=m��[1��&-B�ұHI|:ƺ�Vd���!*�xx 0E�>�[$C���G�[~hX����JԦءb
J!�.�ׯ�bu���͛7�く�      �   n   x�36���L��I,�N-������r2�R��R9U��TTR�RsC<}+*"�"��<}�<�\\����\�ݼ�͊��C�
��*rs=MS�,
3�f�[�s��qqq � j     