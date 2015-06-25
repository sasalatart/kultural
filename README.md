# Grupo 7

**Heroku en** [https://kultural.herokuapp.com](https://kultural.herokuapp.com)

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

- Instalar las gemas necesarias para la aplicación con `bundle install`
- Colocar los siguientes comandos:
	- `rake db:create`
	- `rake db:migrate`
	- `rake db:seed` si se quiere poblar la base de datos
- Para iniciar el server, `rails s` y entrar a `host:puerto`. Por defecto el host es `localhost`y el puerto es 3000.

# Testing

- Test de autentificación: tests que verifican que el sistema de autentificación del usuario esté funcionando. Se hizo este conjunto de test pues el manejo de usuarios es central en el flujo de la aplicación.
- Test de autorización: verifican que el sistema de permisos en la aplicación, esto es, que un usuario pueda acceder y editar solo lo que tiene permitido. Se hizo este conjunto de test pues un buen manejo de permisos es central en la futura experiencia de usuario.
- Tests de modelo de usuarios:
  - Test de creación: muchos tests que se encargan de verificar que existan las validaciones necesarias al momento de crear o editar un usuario. El modelo de usuarios es el modelo que más interactúa con los otros, es por esto que se priorizó su testing.
  - Test de relación seguido-seguidor: tests que verifican que la funcionalidad de seguir usuarios esté funcionando. Este cojunto de tests se hizo pues fue una de las features recalcadas en el enunciado de esta entrega.
- Test de modelo de grupos:
  - Test de creación: conjunto de tests que se encargan de verificar las validaciones al crear o editar un grupo. Está previsto que un grupo pueda interactuar con muchos otras entidades, tal y como un usuario, es por esto que se hizo este cojunto de tests.
  - Test de membresía a grupos: tests que verifican que un usuario se pueda unir a un grupo, y que puedan crear un grupo. 

# Deployment

* [Servidor en Heroku](https://kultural.herokuapp.com)
* Para almacenar las diferentes claves de las API, se ocuparon **variables de entorno**.
