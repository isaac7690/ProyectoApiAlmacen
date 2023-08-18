using ProyectoAPICiclo5.Entidades;
using Microsoft.Data.SqlClient;

namespace ProyectoAPICiclo5.DAO
{
    public class GuiaRecepcionDAO
    {
        private string cadena;

        public GuiaRecepcionDAO()
        {
            cadena = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
        }

        //obtener lista de guias(?)
        public IEnumerable<GuiaRecepcion> GetGuiasRecepcion()
        {
            List<GuiaRecepcion> recepcionesList = new List<GuiaRecepcion>();
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                SqlCommand Command = new SqlCommand("EXEC sp_listarGuiasRecepcion", connection);
                connection.Open();
                SqlDataReader dr = Command.ExecuteReader();
                while (dr.Read())
                {
                    recepcionesList.Add(new GuiaRecepcion()
                    {
                        idGuiaRecepcion = dr.GetInt32(0),
                        idProveedor = dr.GetInt32(1),
                        fechaLlegada = dr.GetString(2),
                        numGuia = dr.GetString(3),
                        idEmpleado = dr.GetInt32(4),
                    });
                }
            }
            return recepcionesList;
        }

        //Agregar Guia
        public string AgregarGuiaRecepcion(GuiaRecepcion recepcion)
        {
            string mensaje = "";
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                try
                {
                    SqlCommand command = new SqlCommand("sp_insert_guiaRecepcion", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@idProveedor", recepcion.idProveedor);
                    command.Parameters.AddWithValue("@fecLlegada", recepcion.fechaLlegada);
                    command.Parameters.AddWithValue("@numGuia", recepcion.numGuia);
                    command.Parameters.AddWithValue("@idEmpleado", recepcion.idEmpleado);
                }
                catch (Exception ex)
                {
                    mensaje = ex.Message;
                }
            }
            return mensaje;
        }

        //Editar Guia
        public string ActualizarGuiaRecepcion(GuiaRecepcion recepcion)
        {
            string mensaje = "";
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                try
                {
                    SqlCommand command = new SqlCommand("sp_update_guiaRecepcion", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@idGuiaRecepcion", recepcion.idGuiaRecepcion);
                    command.Parameters.AddWithValue("@idProveedor", recepcion.idProveedor);
                    command.Parameters.AddWithValue("@fecLlegada", recepcion.fechaLlegada);
                    command.Parameters.AddWithValue("@numGuia", recepcion.numGuia);
                    command.Parameters.AddWithValue("@idEmpleado", recepcion.idEmpleado);
                }
                catch (Exception ex)
                {
                    mensaje = ex.Message;
                }
            }
            return mensaje;
        }

        //Buscar Guia Recepcion por ID
        public GuiaRecepcion GetGuiaRecepcionxId(int id)
        {
            GuiaRecepcion recepcion = new GuiaRecepcion();
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                SqlCommand command = new SqlCommand("sp_buscar_guiaRecepcion", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@idGuiaRecepcion", id);
                connection.Open();
                SqlDataReader dr = command.ExecuteReader();
                while (dr.Read())
                {
                    recepcion.idGuiaRecepcion = dr.GetInt32(0);
                    recepcion.idProveedor = dr.GetInt32(1);
                    recepcion.fechaLlegada = dr.GetString(2);
                    recepcion.numGuia = dr.GetString(3);
                    recepcion.idEmpleado = dr.GetInt32(4);
                }
            }
            return recepcion;
        }

        //Eliminar Producto
        public string EliminarGuiaRecepcion(int id)
        {
            string mensaje = "";

            using (SqlConnection connection = new SqlConnection(cadena))
            {
                try
                {
                    SqlCommand command = new SqlCommand("sp_eliminar_guiaRecepcion", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@idGuiaRecepcion", id);
                    connection.Open();
                    int c = command.ExecuteNonQuery();
                    mensaje = $"Eliminada {c} Guia de recepción";
                }
                catch (Exception ex)
                {
                    mensaje = ex.Message;
                }
            }
            return mensaje;
        }



    }
}  
