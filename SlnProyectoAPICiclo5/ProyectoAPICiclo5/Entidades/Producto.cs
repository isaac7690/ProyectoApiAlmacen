namespace ProyectoAPICiclo5.Entidades
{
    public class Producto
    {
        public int idProducto { get; set; }
        public string? nomProducto { get; set; }
        public int idMarca  { get; set; }
        public string? nomMarca { get; set; }
        public int idCategoria { get; set; }
        public string? nomCategoria { get; set; }
        public string? modeloProducto { get; set; }
        public int cantProducto { get; set; }
    }
}
