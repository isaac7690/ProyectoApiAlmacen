using ProyectoAPICiclo5.Entidades;
using Microsoft.Data.SqlClient;

namespace ProyectoAPICiclo5.DAO
{
    public class MarcaDAO
    {
        private string cadena;
        public MarcaDAO()
        {
            cadena = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
        }

        //lista de marcas (para el combobox de producto)
        public IEnumerable<Marca> GetMarcas()
        {
            List<Marca> marcasList = new List<Marca>();
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                SqlCommand Command = new SqlCommand("EXEC sp_GetMarca", connection);
                connection.Open();
                SqlDataReader dr = Command.ExecuteReader();
                while (dr.Read())
                {
                    marcasList.Add(new Marca()
                    {
                        idMarca = dr.GetInt32(0),
                        nomMarca = dr.GetString(1)
                    });
                }
            }
            return marcasList;
        }
    }
}
