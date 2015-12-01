# Grupo 7
> Using Heroku: https://kulturalapp.herokuapp.com

* Ayudante: **Patricio López** - [@mrpatiwi](https://github.com/mrpatiwi)

Pueden revisar el feedback y evaluación recibida después de cada entrega en la carpeta **feedback**.

## Integrantes:

* Jaime Castro
* Sebastián Salata
* Vicente Dragicevic

## Development

### Setup

1. Set the following environment variables:
  * DB_USER_ID
  * DB_ACCESS_TOKEN
  * DB_APP_KEY
  * DB_APP_SECRET
  * DB_TOKEN_SECRET
  * GMAIL_USERNAME
  * GMAIL_PASSWORD

  **Note**: *DB* means Dropbox in this context.

2. Run the following:
```sh
$ bundle
$ rake db:create db:migrate db:seed
```

### Running the app
```sh
$ rails s
```
