# Movie Application Database

## Entity-Relationship Diagram

```mermaid
erDiagram
    APPUSER {
        int id PK
        string username
        string first_name
        string last_name
        string email
        string password
        int avatar_id FK
        datetime createdAt
        datetime updatedAt
    }
    FILE {
        int id PK
        string file_name
        string mime_type
        string key
        string url
        datetime createdAt
        datetime updatedAt
    }
    MOVIE {
        int id PK
        string title
        text description
        decimal budget
        date release_date
        int duration
        int director_id FK
        int country_id FK
        int poster_id FK
        datetime createdAt
        datetime updatedAt
    }
    GENRE {
        int id PK
        string name
    }
    MOVIEGENRE {
        int movie_id PK
        int genre_id PK
    }
    CHARACTER {
        int id PK
        string name
        text description
        string role
        int movie_id FK
        int person_id FK
        datetime createdAt
        datetime updatedAt
    }
    PERSON {
        int id PK
        string first_name
        string last_name
        text biography
        date date_of_birth
        string gender
        int country_id FK
        int primary_photo_id FK
        datetime createdAt
        datetime updatedAt
    }
    FAVORITEMOVIES {
        int user_id PK
        int movie_id PK
    }
    COUNTRY {
        int id PK
        string name
    }

    APPUSER ||--o{ FILE : has
    MOVIE ||--o{ FILE : has
    PERSON ||--o{ FILE : has
    MOVIE ||--o{ GENRE : has
    CHARACTER }o--|| PERSON : played_by
    MOVIE ||--o{ CHARACTER : has
    MOVIE ||--|| PERSON : directed_by
    MOVIE ||--|| COUNTRY : produced_in
    PERSON ||--|| COUNTRY : from
    APPUSER ||--o{ FAVORITEMOVIES : has_favorites