CLASS zcl_itab_nesting DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF artists_type,
             artist_id   TYPE string,
             artist_name TYPE string,
           END OF artists_type.
    TYPES artists TYPE STANDARD TABLE OF artists_type WITH KEY artist_id.
    TYPES: BEGIN OF albums_type,
             artist_id  TYPE string,
             album_id   TYPE string,
             album_name TYPE string,
           END OF albums_type.
    TYPES albums TYPE STANDARD TABLE OF albums_type WITH KEY artist_id album_id.
    TYPES: BEGIN OF songs_type,
             artist_id TYPE string,
             album_id  TYPE string,
             song_id   TYPE string,
             song_name TYPE string,
           END OF songs_type.
    TYPES songs TYPE STANDARD TABLE OF songs_type WITH KEY artist_id album_id song_id.

    TYPES: BEGIN OF song_nested_type,
             song_id   TYPE string,
             song_name TYPE string,
           END OF song_nested_type.
    TYPES: BEGIN OF album_song_nested_type,
             album_id   TYPE string,
             album_name TYPE string,
             songs      TYPE STANDARD TABLE OF song_nested_type WITH KEY song_id,
           END OF album_song_nested_type.
    TYPES: BEGIN OF artist_album_nested_type,
             artist_id   TYPE string,
             artist_name TYPE string,
             albums      TYPE STANDARD TABLE OF album_song_nested_type WITH KEY album_id,
           END OF artist_album_nested_type.
    TYPES nested_data TYPE STANDARD TABLE OF artist_album_nested_type WITH KEY artist_id.

    METHODS perform_nesting
      IMPORTING
        artists            TYPE artists
        albums             TYPE albums
        songs              TYPE songs
      RETURNING
        VALUE(nested_data) TYPE nested_data.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_itab_nesting IMPLEMENTATION.

  METHOD perform_nesting.
    DATA: lv_artist_id   TYPE string,
          lv_album_id    TYPE string,
          lv_artist_name TYPE string,
          lv_album_name  TYPE string.

    FIELD-SYMBOLS: <lwa_nested>       TYPE artist_album_nested_type,
                   <lwa_nested_album> TYPE album_song_nested_type,
                   <lwa_nested_song>  TYPE song_nested_type.

    "tried to use select from itab, but it seems that it is not supported yet"
    DATA(lt_artists) = artists.
    DATA(lt_albums)  = albums.
    DATA(lt_songs)   = songs.
    sort lt_artists by artist_id.
    sort lt_albums  by artist_id album_id.
    sort lt_songs   by artist_id album_id.

    LOOP AT lt_artists ASSIGNING FIELD-SYMBOL(<lwa_artist>).
      IF <lwa_artist> IS INITIAL OR <lwa_artist> IS NOT ASSIGNED.
        CONTINUE.
      ENDIF.
      lv_artist_id   = <lwa_artist>-artist_id.
      lv_artist_name = <lwa_artist>-artist_name.
      IF lv_artist_id IS NOT INITIAL.
        "writing data - artist level
        APPEND INITIAL LINE TO nested_data ASSIGNING <lwa_nested>.
        <lwa_nested>-artist_id   = lv_artist_id.
        <lwa_nested>-artist_name = lv_artist_name.

        "find first album
        READ TABLE lt_albums WITH KEY artist_id = lv_artist_id TRANSPORTING NO FIELDS BINARY SEARCH.
        IF SY-SUBRC IS INITIAL. "record found
          LOOP AT lt_albums FROM SY-TABIX ASSIGNING FIELD-SYMBOL(<lwa_album>).
            IF <lwa_album>-artist_id <> lv_artist_id.
              EXIT.
            ENDIF.
            "writing data - album level
            APPEND INITIAL LINE TO <lwa_nested>-albums ASSIGNING <lwa_nested_album>.
            <lwa_nested_album>-album_id   = <lwa_album>-album_id.
            <lwa_nested_album>-album_name = <lwa_album>-album_name.

            "find first song
            READ TABLE lt_songs WITH KEY artist_id = lv_artist_id
                                      album_id  = <lwa_album>-album_id TRANSPORTING NO FIELDS BINARY SEARCH.
            IF SY-SUBRC IS INITIAL. "record found
              LOOP AT lt_songs FROM SY-TABIX ASSIGNING FIELD-SYMBOL(<lwa_song>).
                IF <lwa_song>-artist_id <> lv_artist_id OR <lwa_song>-album_id <> <lwa_album>-album_id.
                  EXIT.
                ENDIF.

                "writing data - song level
                APPEND INITIAL LINE TO <lwa_nested_album>-songs ASSIGNING <lwa_nested_song>.
                <lwa_nested_song>-song_id   = <lwa_song>-song_id.
                <lwa_nested_song>-song_name = <lwa_song>-song_name.
              ENDLOOP.
            ENDIF.
          ENDLOOP.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
