using ProyectoAPICiclo5.Entidades;
using Microsoft.Data.SqlClient;

namespace ProyectoAPICiclo5.DAO
{
    public class CategoriaProductoDAO
    {
        private string cadena;

        public CategoriaProductoDAO()
        {
            cadena = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
        }

        //lista de categorias (para el combobox de producto)
        public IEnumerable<CategoriaProducto> GetCategoriaProducto()
        {
            List<CategoriaProducto> categoriasList = new List<CategoriaProducto>();
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                SqlCommand Command = new SqlCommand("EXEC sp_GetCategoriaProducto", connection);
                connection.Open();
                SqlDataReader dr = Command.ExecuteReader();
                while (dr.Read())
                {
                    categoriasList.Add(new CategoriaProducto()
                    {
                        idCategoria = dr.GetInt32(0),
                        nomCategoria = dr.GetString(1)
                    });
                }
            }
            return categoriasList;
        }

    }
}
