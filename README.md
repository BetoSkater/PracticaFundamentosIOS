# PracticaFundamentosIOS
Práctica final del módulo "Fundamentos de iOS"

# NOTAS:

## Requisitos mínimos:

  Toda la funcionalidad pedida está realizada. Para un usuario nuevo, la navegación es:
  
  1. Pantalla de carga.
  2. Login
  3. TableViewController (listado de heroes)
    1. Detalle heroe.
    2. Listado de transformaciones.
    3. Detalle de la transformación.
  4. CollectionViewController (listado de heroes favoritos)
    1. Detalle heroe.
    2. Listado de transformaciones.
    3. Detalle de la transformación.
  5.Settings (contiene un botón para hacer logout).
  
## Añadido
  Como me ha sobrado tiempo, he decidido crear la llamada a la api para marcar a los héroes como favoritos. No he tenido tiempo suficiente 
  para que funcione como yo quiero. 
  
  Lo que funciona bien de esto ultimo:
  - Desde el lisado de heroes del tableView se puede acceder a la vista detalle. Aqui, al pulsar en la estrellita, se hace la llamada a la 
  API y el heroe pasa a estar como favorito (o se desmarca como favorito). Con un protocolo delegado, se modifica el listado de heroes del tableView 
  anterior para reflejar el cambio. Al volver a acceder al detalle, se verá marcado como favorito. 
  
  Lo que no he conseguido:
  - No he conseguido con un mismo delegado que se modifique además en la colección de héroes favoritos. Lo cual tiene sentido porque si el
  delegado tiene los valos del TableView, no puede ser al mismo tiempo el delegado del CollectionView. Por lo que para que la colección de favoritos
  funcione se ha de abrir la aplicación de nuevo tras haber marcado al menos un heroe como favorito. 
  - Cuando se accede a la vista detalle de un heroe desde la colección de favoritos para marcar o desmarcar un heroe como favorito,
  no se actualiza la colección de favoritos con el delegado. 
  Nunca entra en el método sobreescrito del protocolo delegado en el collectionView. El motivo es el mismo, DetalleController no puede tener dos delegados 
  distintos para la conformación del protocolo en dos controladores distintos (o al menos yo no he logrado hacerlo asi).
  
  Con todo esto, para ver los cambios en el collectionView se tiene que cerrar y abrir la app.  No estoy seguro si lo que he intentado hacer es posible 
  con los delegados.
  
  Un saludo,
  
  Alberto
