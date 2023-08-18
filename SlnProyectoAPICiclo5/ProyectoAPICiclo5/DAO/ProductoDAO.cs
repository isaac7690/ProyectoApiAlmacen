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

        //obtener lista de productos
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

        //agregar nuevo producto
        public string AgregarProducto(Producto producto)
        {

            string mensaje = "";
            using(SqlConnection connection = new SqlConnection(cadena))
            {
                try
                {
                    SqlCommand command = new SqlCommand("sp_insert_producto", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@prmNomProducto", producto.nomProducto);
                    command.Parameters.AddWithValue("@prmIdMarca", producto.idMarca);
                    command.Parameters.AddWithValue("@prmModeloProducto", producto.modeloProducto);
                    command.Parameters.AddWithValue("@prmCantProducto", producto.cantProducto);
                    command.Parameters.AddWithValue("@prmIdCategoria", producto.idCategoria);
                }
                catch(Exception ex) 
                {
                    mensaje = ex.Message;
                }
            }
            return mensaje;
        }


        //actualizar producto
        public string ActualizarProducto(Producto producto)
        {
            string mensaje = "";
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                try
                {
                    SqlCommand command = new SqlCommand("sp_UpdateProducto", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@prmIdProducto", producto.idProducto);
                    command.Parameters.AddWithValue("@prmNomProducto", producto.nomProducto);
                    command.Parameters.AddWithValue("@prmIdMarca", producto.idMarca);
                    command.Parameters.AddWithValue("@prmModeloProducto", producto.modeloProducto);
                    command.Parameters.AddWithValue("@prmCantProducto", producto.cantProducto);
                    command.Parameters.AddWithValue("@prmIdCategoria", producto.idCategoria);
                }
                catch (Exception ex)
                {
                    mensaje = ex.Message;
                }
            }
            return mensaje;
        }

        //buscar producto por ID
        public Producto GetProductoxId(int id)
        {
            Producto producto = new Producto();
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                SqlCommand command = new SqlCommand("sp_buscar_productoId", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@prmIdProducto", id);
                connection.Open();
                SqlDataReader dr = command.ExecuteReader();
                while (dr.Read())
                {
                    producto.idProducto = dr.GetInt32(0);
                    producto.nomProducto = dr.GetString(1);
                    producto.idMarca = dr.GetInt32(2);
                    producto.modeloProducto = dr.GetString(3);
                    producto.cantProducto = dr.GetInt32(4);
                    producto.idCategoria = dr.GetInt32(5);
                }
            }
            return producto;
        }

        //Eliminar Producto
        public string EliminarProducto(int id)
        {
            string mensaje = "";

            using (SqlConnection connection = new SqlConnection(cadena))
            {
                try
                {
                    SqlCommand command = new SqlCommand("sp_EliminarProducto", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@prmIdCliente", id);
                    connection.Open();
                    int c = command.ExecuteNonQuery();
                    mensaje = $"Eliminado {c} producto";
                }
                catch(Exception ex)
                {
                    mensaje = ex.Message;
                }
            }
            return mensaje;
        }


    }
}
