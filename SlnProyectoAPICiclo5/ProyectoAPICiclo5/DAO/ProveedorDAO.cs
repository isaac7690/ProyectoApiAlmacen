using ProyectoAPICiclo5.Entidades;
using Microsoft.Data.SqlClient;

namespace ProyectoAPICiclo5.DAO
{
    public class ProveedorDAO
    {
        private string cadena;

        public ProveedorDAO()
        {
            cadena = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
        }

        //lista de proveedores
        public IEnumerable<Proveedor> GetProveedores()
        {
            List<Proveedor> proveedoresList = new List<Proveedor>();
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                SqlCommand command = new SqlCommand("sp_listar_provedores", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                connection.Open();
                SqlDataReader dr = command.ExecuteReader();
                while (dr.Read())
                {
                    proveedoresList.Add(new Proveedor()
                    {
                       idProveedor = dr.GetInt32(0),
                       rucProveedor = dr.GetString(1),
                       razonSocialProveedor = dr.GetString(2),
                       telefono = dr.GetString(3)
                    });
                }
            }
            return proveedoresList;
        }

        //agregar proveedor
        public string AgregarProveedor(Proveedor proveedor)
        {
            string mensaje = "";
            using(SqlConnection connection = new SqlConnection(cadena))
            {
                try
                {
                    SqlCommand command = new SqlCommand("sp_insert_proveedores", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@rucProveedor", proveedor.rucProveedor);
                    command.Parameters.AddWithValue("@razonSocialProveedor", proveedor.razonSocialProveedor);
                    command.Parameters.AddWithValue("@telefono", proveedor.telefono);
                }
                catch (Exception ex)
                {
                    mensaje = ex.Message;
                }
            }
            return mensaje;
        }

        //editar proveedor
        public string ActualizarProveedor(Proveedor proveedor)
        {
            string mensaje = "";
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                try
                {
                    SqlCommand command = new SqlCommand("sp_update_proveedor", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@idProveedor", proveedor.idProveedor);
                    command.Parameters.AddWithValue("@rucProveedor", proveedor.rucProveedor);
                    command.Parameters.AddWithValue("@razonSocialProveedor", proveedor.razonSocialProveedor);
                    command.Parameters.AddWithValue("@telefono", proveedor.telefono);
                }
                catch (Exception ex)
                {
                    mensaje = ex.Message;
                }
            }
            return mensaje;
        }

        //Buscar Proveedor por ID
        public Proveedor GetProveedorxId(int id)
        {
            Proveedor proveedor = new Proveedor();
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                SqlCommand command = new SqlCommand("sp_buscar_proveedor", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@idProveedor", id);
                connection.Open();
                SqlDataReader dr = command.ExecuteReader();
                while (dr.Read())
                {
                    proveedor.idProveedor = dr.GetInt32(1);
                    proveedor.rucProveedor = dr.GetString(2);
                    proveedor.razonSocialProveedor = dr.GetString(3);
                    proveedor.telefono = dr.GetString(4);
                }
            }
            return proveedor;
        }

        //eliminar proveedor
        public string EliminarProveedor(int id)
        {
            string mensaje = "";
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                try
                {
                    SqlCommand command = new SqlCommand("sp_eliminar_proveedor", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@idProveedor", id);
                    connection.Open();
                    int c = command.ExecuteNonQuery();
                    mensaje = $"Eliminado {c} proveedor";
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
