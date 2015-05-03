# Grupo 7

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
- Postgresql
	- Rol de la aplicación: `kultural`
	- Password: `kulturalpass`
	- Consulta que lo hace: `create role kultural with createdb login password 'kulturalpass';`
- Ruby 2.2.1
- Rails 4.2.1

**La aplicación está en la carpeta `kultural`** 

## Pasos a seguir

- Instalar las gemas necesarias para la aplicación. Son las ''por defecto'', más `annotate` y `pg`. El detalle está en el `Gemfile`
- Colocar los siguientes comandos:
	- `rake db:create`
	- `rake db:migrate`
	- `rake db:seed` si se quiere poblar la base de datos
- Para iniciar el server, `rails s` y entrar a `host:puerto`. Por defecto el host es `localhost`y el puerto es 3000.

# Deployment

Cuando sea solicitado, aquí se deberá indicar la URL de la aplicación corriendo en un servidor externo.
