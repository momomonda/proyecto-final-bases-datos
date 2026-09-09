##


1. Integrantes del Equipo
   
- Daniel Felipe Montero Sáenz 1 (1080181337 / danielfelipemonterosaenz@gmail.com)
- Samuel Tuberquia David 2 (1013461129 / samueltuberquiad@gmail.com)
- Chelssea Faria Moreno 3 (Documento / Correo)

  
##



2.  TALLER MECÁNICO DE MOTOS
   
- Debido al incremento de nuevos vehículos, es muy favorable implementar talleres capacitados, ya que esto ayuda a gestionar
  de mejor manera las solicitudes y reparaciones necesarias.
  
- Obtener citas para proceder a reparaciones y ajuste de motocicletas, logrando tener un control de citas acorde con los tiempos                    establecidos por la aplicación.

  
##



3. Entidades Principales del Dominio
   
   - Cliente: Representa a la persona (natural o jurídica) que solicita el servicio de ajuste o reparación para uno o varios                           artículos. Almacena la información de contacto y datos de identificación necesarios para la gestión del servicio.
     1:N (Uno a Muchos) un cliente puede realizar múltiples solicitudes de servicio a lo largo del tiempo, pero cada servicio o          entrega       está asociado a un único cliente principal).
     
   - Tipo de Ajuste o Reparación :  Define el catálogo o la categoría de los trabajos específicos que se pueden realizar sobre los                     artículos (por ejemplo: entallar, cambiar cremallera, ajustar dobladillo, reparación de calzado, etc.). Establece la                              naturaleza del servicio solicitado.
     N:M(Muchos a Muchos)ya que una misma reparación puede aplicarse a varios servicios y una orden de servicio puede incluir                          múltiples tipos de ajustes.
     
   - Mano de Obra : Representa el trabajo humano, el tiempo invertido y el costo asociado de los operarios o técnicos que ejecutan                     efectivamente las labores necesarias para completar el ajuste o la reparación. Permite calcular el valor operativo del              servicio      prestado.
     1:N(Uno a Muchos) una orden o tipo de ajuste puede requerir diferentes labores de mano de obra, pero cada registro de mano de       obra          responde a un servicio o ajuste específico.
     
   - Dia de Entrega: Gestiona la programación temporal, la agenda y el compromiso pactado con el cliente para la culminación y                         devolución del artículo reparado. Controla fechas límites y estados de entrega (pendiente, entregado, retrasado).
     1:1 - 1:N (Uno a Uno / Uno a Muchos) con el Cliente y el servicio asociado (cada orden o servicio tiene asignado un día de          entrega       específico en el calendario).

     
##



4. Matriz de Entornos y Conexiones
   
- Motores y proveedores probados:
- SQLite (archivo local)
- MySQL (Aiven.io)
- PostgreSQL (Neon.tech)
- PostgreSQL (Render.com)

##

5. Instrucciones de Ejecución
- Comando de instalacion de librerias: `pip install peewee psycopg2-binary pymysql'
- Comando para ejecutar la aplicacion: `python app.py'