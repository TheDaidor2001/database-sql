SELECT 
    m.id, 
    m.title, 
    m.release_date, 
    m.duration, 
    m.description,
    json_build_object('id', f.id, 'file_name', f.file_name, 'url', f.url) AS poster,
    json_build_object('id', d.id, 'first_name', d.first_name, 'last_name', d.last_name, 
                      'photo', json_build_object('id', pf.id, 'file_name', pf.file_name, 'url', pf.url)) AS director,
    (SELECT json_agg(json_build_object('id', actor_data.id, 'first_name', actor_data.first_name, 'last_name', actor_data.last_name, 
                                       'photo', json_build_object('id', actor_data.af_id, 'file_name', actor_data.af_file_name, 'url', actor_data.af_url)))
     FROM (
         SELECT DISTINCT a.id, a.first_name, a.last_name, af.id AS af_id, af.file_name AS af_file_name, af.url AS af_url
         FROM Character c
         LEFT JOIN Person a ON c.person_id = a.id
         LEFT JOIN File af ON a.primary_photo_id = af.id
         WHERE c.movie_id = m.id
     ) AS actor_data) AS actors,
    (SELECT json_agg(json_build_object('id', genre_data.id, 'name', genre_data.name))
     FROM (
         SELECT DISTINCT g.id, g.name
         FROM MovieGenre mg
         JOIN Genre g ON mg.genre_id = g.id
         WHERE mg.movie_id = m.id
     ) AS genre_data) AS genres
FROM 
    Movie m
LEFT JOIN 
    File f ON m.poster_id = f.id
LEFT JOIN 
    Person d ON m.director_id = d.id
LEFT JOIN 
    File pf ON d.primary_photo_id = pf.id
WHERE 
    m.id = 1
GROUP BY 
    m.id, f.id, d.id, pf.id;