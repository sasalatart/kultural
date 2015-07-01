# Grupo 7

**Heroku en** [https://kulturalapp.herokuapp.com](https://kulturalapp.herokuapp.com)

* Proyecto a trabajar: [Central de Eventos](https://github.com/IIC2513-2015-1/syllabus/blob/master/Proyectos/Central-de-eventos.md)
* Ayudante: **Patricio López** - [@mrpatiwi](https://github.com/mrpatiwi) - pelopez2@uc.cl

Pueden revisar el feedback y evaluación recibida después de cada entrega en la carpeta **feedback**.

## Integrantes:
Asegúrense de llenar lo siguiente:

| Nº Alumno    | Nombre              | Email UC         |
|:-------------|:--------------------|:-----------------|
| 12634212     | Jaime Castro        | jecastro1@uc.cl  |
| 12635723     | Vicente Dragicevic  |vrdragicevic@uc.cl|
| 11633514     | Sebastián Salata    |  sasalata@uc.cl  |

# Instrucciones

## Requisitos previos
- Postgresql:
	- Rol de la aplicación: `kultural`
	- Password: `kulturalpass`
	- Consulta que lo hace: `create role kultural with createdb login password 'kulturalpass';`
- Ruby 2.2.1
- Rails 4.2.1

**La aplicación está en la carpeta `kultural`**

## Para *development*:
- Instalar las gemas necesarias para la aplicación con `bundle install`.
- Ejecutar los siguientes comandos:
	- `rake db:create`
	- `rake db:migrate`
	- `rake db:seed` (si se desea poblar la base de datos).
- Ejecutar `rails s` y navegar con un browser a `localhost:3000`.

# Deployment

* [Servidor en Heroku](https://kulturalapp.herokuapp.com)
* Para almacenar las claves y tokens, se ocuparon **variables de entorno**.
