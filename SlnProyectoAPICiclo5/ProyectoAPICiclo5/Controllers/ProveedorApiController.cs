using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ProyectoAPICiclo5.Entidades;
using ProyectoAPICiclo5.DAO;

namespace ProyectoAPICiclo5.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProveedorApiController : ControllerBase
    {
        //lista de proveedores
        [HttpGet("GetProveedores")]
        public async Task<ActionResult<List<Producto>>> GetProveedores()
        {
            var lista = await Task.Run(() => (new ProveedorDAO()).GetProveedores());
            return Ok(lista);
        }

        //agregar proveedor
        [HttpPost("AgregarProveedor")]
        public async Task<ActionResult<String>> AgregarProveedor(Proveedor proveedor)
        {
            var mensaje = await Task.Run(() => (new ProveedorDAO()).AgregarProveedor(proveedor));
            return Ok(mensaje);
        }

        //actualizar proveedor
        [HttpPut("ActualizarProveedor")]
        public async Task<ActionResult<String>> ActualizarProveedor(Proveedor proveedor)
        {
            var mensaje = await Task.Run(() => (new ProveedorDAO()).ActualizarProveedor(proveedor));
            return Ok(mensaje);
        }

        //buscar proveedor por ID
        [HttpGet("GetProveedorxId/{id}")]
        public async Task<ActionResult<Producto>> GetProveedorxId(int id)
        {
            var proveedor = await Task.Run(() => (new ProveedorDAO()).GetProveedorxId(id));
            return Ok(proveedor);
        }

        //eliminar proveedor
        [HttpDelete("EliminarProveedor")]
        public async Task<ActionResult<String>> EliminarProveedor(int id)
        {
            var mensaje = await Task.Run(() => (new ProveedorDAO()).EliminarProveedor(id));
            return Ok(mensaje);
        }

    }
}
