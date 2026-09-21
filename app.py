from peewee import *

# ==================================================
# CONFIGURACION DE CONEXION
# ==================================================

# Cambia este valor para alternar entre motores
MOTOR_ACTIVO = "postgres_neon" 

if MOTOR_ACTIVO == "sqlite":
    db = SqliteDatabase("taller.db")

elif MOTOR_ACTIVO == "postgres_neon":
    
    db = PostgresqlDatabase(
        'neondb', # Nombre de la base de datos (por defecto suele ser neondb)
        user='tu_usuario', # Tu rol/usuario en Neon
        password='tu_contraseña', # Tu contraseña de Neon
        host='ep-nombre-del-host-123456.us-east-2.aws.neon.tech', # El Endpoint que te da Neon
        port=5432,
        sslmode='require' # Requisito indispensable para conexiones a Neon.tech
    )


# ==================================================
# MODELO BASE
# ==================================================

class BaseModel(Model):
    class Meta:
        database = db


# ==================================================
# MODELOS
# ==================================================

class Cliente(BaseModel):
    nombre = CharField()
    telefono = CharField(null=True)
    correo = CharField(null=True)
    direccion = CharField(null=True)

class TipoAjuste(BaseModel):
    nombre_servicio = CharField()
    descripcion = TextField(null=True)
    costo_base = FloatField()

class OrdenServicio(BaseModel):
    cliente = ForeignKeyField(
        Cliente,
        backref="ordenes",
        on_delete="CASCADE"
    )
    fecha_cita = DateTimeField()
    estado = CharField(
        default="pendiente"
    )

class DetalleOrdenAjuste(BaseModel):
    orden = ForeignKeyField(
        OrdenServicio,
        backref="detalles",
        on_delete="CASCADE"
    )
    ajuste = ForeignKeyField(
        TipoAjuste,
        backref="ordenes",
        on_delete="CASCADE"
    )

    class Meta:
        indexes = (
            (
                ('orden', 'ajuste'),
                True
            ),
        )

class ManoObra(BaseModel):
    orden = ForeignKeyField(
        OrdenServicio,
        backref="mano_obra",
        on_delete="CASCADE"
    )
    descripcion_labor = TextField()
    tiempo_invertido_horas = FloatField()
    costo_operario = FloatField()


# ==================================================
# CRUD DE PRUEBA
# ==================================================

def ejecutar_pruebas():

    db.connect()

    db.create_tables([
        Cliente,
        TipoAjuste,
        OrdenServicio,
        DetalleOrdenAjuste,
        ManoObra
    ], safe=True)

    print("\n=== CONEXION EXITOSA ===\n")

    # ----------------------------------
    # CREATE
    # ----------------------------------

    cliente = Cliente.create(
        nombre="Juan Perez",
        telefono="3001112233",
        correo="juan@email.com",
        direccion="Medellin"
    )
    print(f"[CREATE] Cliente creado ID: {cliente.id}")

    ajuste = TipoAjuste.create(
        nombre_servicio="Cambio de pantalla",
        descripcion="Pantalla dañada",
        costo_base=150000
    )
    print(f"[CREATE] Ajuste creado ID: {ajuste.id}")

    orden = OrdenServicio.create(
        cliente=cliente,
        fecha_cita="2025-09-15 10:00:00",
        estado="pendiente"
    )
    print(f"[CREATE] Orden creada ID: {orden.id}")

    DetalleOrdenAjuste.create(
        orden=orden,
        ajuste=ajuste
    )

    ManoObra.create(
        orden=orden,
        descripcion_labor="Desmontaje y montaje",
        tiempo_invertido_horas=2,
        costo_operario=50000
    )

    # ----------------------------------
    # READ
    # ----------------------------------

    print("\n=== CONSULTA ===\n")

    for o in OrdenServicio.select():
        print(f"Orden {o.id}")
        print(f"Cliente: {o.cliente.nombre}")
        print(f"Estado: {o.estado}")

    # ----------------------------------
    # UPDATE
    # ----------------------------------

    orden.estado = "en_proceso"
    orden.save()
    print(f"\n[UPDATE] Nuevo estado: {orden.estado}")

    # ----------------------------------
    # DELETE
    # ----------------------------------

    mano = ManoObra.get(
        ManoObra.orden == orden
    )
    mano.delete_instance()
    print("[DELETE] Registro de mano de obra eliminado")

    db.close()
    print("\nConexion cerrada correctamente.")


if __name__ == "__main__":
    ejecutar_pruebas()
