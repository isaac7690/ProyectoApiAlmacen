using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ProyectoAPICiclo5.Entidades;
using ProyectoAPICiclo5.DAO;

namespace ProyectoAPICiclo5.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductoApiController : ControllerBase
    {
        //lista de productos
        [HttpGet("GetProductos")]
        public async Task<ActionResult<List<Producto>>> GetProductos()
        {
            var lista = await Task.Run(() => (new ProductoDAO()).GetProductos());
            return Ok(lista);
        }

        //agregar producto
        [HttpPost("AgregarProducto")]
        public async Task<ActionResult<String>> InsertarProducto(Producto producto)
        {
            var mensaje = await Task.Run(() => (new ProductoDAO()).AgregarProducto(producto));
            return Ok(mensaje);
        }

        //actualizar producto
        [HttpPut("ActualizarProducto")]
        public async Task<ActionResult<String>> ActualizarProducto(Producto producto)
        {
            var mensaje = await Task.Run(() => (new ProductoDAO()).ActualizarProducto(producto));
            return Ok(mensaje);
        }

        //buscar producto por ID
        [HttpGet("GetProductoxId/{id}")]
        public async Task<ActionResult<Producto>> GetProductoId(int id)
        {
            var producto = await Task.Run(() => (new ProductoDAO()).GetProductoxId(id));
            return Ok(producto);
        }

        [HttpDelete("EliminarProducto")]
        public async Task<ActionResult<String>> EliminarProducto(int id)
        {
            var mensaje = await Task.Run(() => (new ProductoDAO()).EliminarProducto(id));
            return Ok(mensaje);
        }

    }
}
