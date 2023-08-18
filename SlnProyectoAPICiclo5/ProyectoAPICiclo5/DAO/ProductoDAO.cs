using ProyectoAPICiclo5.Entidades;
using Microsoft.Data.SqlClient;

namespace ProyectoAPICiclo5.DAO
{
    public class ProductoDAO
    {
        private string cadena;

        public ProductoDAO()
        {
            cadena = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
        }

        public IEnumerable<Producto> GetProductos()
        {
            List<Producto> productosList = new List<Producto>();
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                SqlCommand Command = new SqlCommand("EXEC sp_listaProductos", connection);
                connection.Open();
                SqlDataReader dr = Command.ExecuteReader();
                while (dr.Read())
                {
                    productosList.Add(new Producto()
                    {
                       idProducto = dr.GetInt32(0),
                       nomProducto = dr.GetString(1),
                       idMarca = dr.GetInt32(2),
                       nomMarca = dr.GetString(3),
                       idCategoria = dr.GetInt32(4),
                       nomCategoria = dr.GetString(5),
                       modeloProducto = dr.GetString(6),
                       cantProducto = dr.GetInt32(7)
                    });
                }
            }
            return productosList;
        }
    }
}
