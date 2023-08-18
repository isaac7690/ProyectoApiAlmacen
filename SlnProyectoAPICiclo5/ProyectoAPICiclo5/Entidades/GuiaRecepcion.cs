namespace ProyectoAPICiclo5.Entidades
{
    public class GuiaRecepcion
    {
        public int idGuiaRecepcion { get; set; }
        public int idProveedor { get; set; }
        public string? razonSocialProveedor { get; set; }
        public string? fechaLlegada { get; set; }
        public string? numGuia { get; set; }
        public int idEmpleado { get; set; }
        public string nomEmpleado { get; set; }
    }
}
