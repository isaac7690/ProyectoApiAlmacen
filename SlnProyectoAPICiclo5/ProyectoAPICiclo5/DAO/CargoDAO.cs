using ProyectoAPICiclo5.Entidades;
using Microsoft.Data.SqlClient;

namespace ProyectoAPICiclo5.DAO
{
    public class CargoDAO
    {
        private string cadena;
        public CargoDAO()
        {
            cadena = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build().GetConnectionString("connection");
        }

        //listado de Cargos (para el combo box)
        public IEnumerable<Cargo> GetCargos()
        {
            List<Cargo> cargosList = new List<Cargo>();
            using (SqlConnection connection = new SqlConnection(cadena))
            {
                SqlCommand command = new SqlCommand("sp_GetCargo", connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                connection.Open();
                SqlDataReader dr = command.ExecuteReader();
                while (dr.Read())
                {
                    cargosList.Add(new Cargo()
                    {
                        idCargo = dr.GetInt32(0),
                        nomCargo = dr.GetString(1)
                    });
                }
            }
            return cargosList;
        }

    }
}
