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

        public IEnumerable<GuiaRecepcion> GetGuiasRecepcion()
        {
            List<GuiaRecepcion> recepcionesList = new List<GuiaRecepcion>();
            using(SqlConnection connection = new SqlConnection(cadena))
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





    }
}
