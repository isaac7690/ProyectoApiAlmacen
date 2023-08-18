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
        [HttpGet("GetProductos")]
        public async Task<ActionResult<List<Producto>>> GetProductos()
        {
            var lista = await Task.Run(() => (new ProductoDAO()).GetProductos());
            return Ok(lista);
        }
    }
}
