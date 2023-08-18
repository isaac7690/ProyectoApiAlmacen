using ProyectoAPICiclo5.Entidades;
using Microsoft.Data.SqlClient;

namespace ProyectoAPICiclo5.DAO
{
    public class EmpleadoDAO
    {
        private string cadena;

        public EmpleadoDAO()
        {
            cadena = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
        }


        //Get Empleados(para el combo box en guia_recepcion)
        public IEnumerable<Empleado> GetEmpleadoCbo()
        {
            List<Empleado> empleadoCbo = new List<Empleado>();
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                SqlCommand command = new SqlCommand("sp_GetEmpleadosCbo", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                connection.Open();
                SqlDataReader dr = command.ExecuteReader();
                while (dr.Read())
                {
                    empleadoCbo.Add(new Empleado()
                    {
                        idEmpleado = dr.GetInt32(0),
                        nomEmpleado = dr.GetString(1)
                    });
                }
            }
            return empleadoCbo;
        }


        //listar Empleados
        public IEnumerable<Empleado> GetEmpleados()
        {
            List<Empleado> empleadosList = new List<Empleado>();
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                SqlCommand command = new SqlCommand("sp_listar_empleados", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                connection.Open();
                SqlDataReader dr = command.ExecuteReader();
                while (dr.Read())
                {
                    empleadosList.Add(new Empleado()
                    {
                        idEmpleado = dr.GetInt32(0),
                        nomEmpleado = dr.GetString(1),
                        idCargo = dr.GetInt32(2),
                        nomCargo = dr.GetString(3),
                        dniEmpleado = dr.GetString(4)
                    });
                }
            }
            return empleadosList;
        }

        //agregar empleado
        public string AgregarEmpleado(Empleado empleado)
        {
            string mensaje = "";
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                try
                {
                    SqlCommand command = new SqlCommand("sp_insert_empleado", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@nomEmpleado", empleado.nomEmpleado);
                    command.Parameters.AddWithValue("@idCargo", empleado.idCargo);
                    command.Parameters.AddWithValue("@dniEmpleado", empleado.dniEmpleado);
                }
                catch (Exception ex)
                {
                    mensaje = ex.Message;
                }
            }
            return mensaje;
        }

        //actualizar empleado
        public string ActualizarEmpleado(Empleado empleado)
        {
            string mensaje = "";
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                try
                {
                    SqlCommand command = new SqlCommand("sp_update_empleado", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@idEmpleado", empleado.idEmpleado);
                    command.Parameters.AddWithValue("@nomEmpleado", empleado.nomEmpleado);
                    command.Parameters.AddWithValue("@idCargo", empleado.idCargo);
                    command.Parameters.AddWithValue("@dniEmpleado", empleado.dniEmpleado);
                }
                catch (Exception ex)
                {
                    mensaje = ex.Message;
                }
            }
            return mensaje;
        }

        //buscar empleado por ID
        public Empleado GetEmpleadoxId(int id)
        {
            Empleado empleado = new Empleado();
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                SqlCommand command = new SqlCommand("sp_buscar_empleado", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@idEmpleado", id);
                connection.Open();
                SqlDataReader dr = command.ExecuteReader();
                while (dr.Read())
                {
                    empleado.idEmpleado = dr.GetInt32(1);
                    empleado.nomEmpleado = dr.GetString(2);
                    empleado.idCargo = dr.GetInt32(3);
                    empleado.dniEmpleado = dr.GetString(4);
                }
            }
            return empleado;
        }

        //eliminar empleado
        public string EliminarEmpleado(int id)
        {
            string mensaje = "";
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                try
                {
                    SqlCommand command = new SqlCommand("sp_eliminar_empleado", connection);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@idEmpleado", id);
                    connection.Open();
                    int c = command.ExecuteNonQuery();
                    mensaje = $"Eliminado {c} empleado";
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
