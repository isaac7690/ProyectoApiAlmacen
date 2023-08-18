using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ProyectoAPICiclo5.Entidades;
using ProyectoAPICiclo5.DAO;

namespace ProyectoAPICiclo5.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GuiaRecepcionApiController : ControllerBase
    {
        //listado
        [HttpGet("GetGuiasRecepcion")]
        public async Task<ActionResult<List<GuiaRecepcion>>> GetGuiaRecepcion()
        {
            var lista = await Task.Run(() => (new GuiaRecepcionDAO()).GetGuiasRecepcion());
            return Ok(lista);
        }

        //agregar guia recepcion
        [HttpPost("AgregarGuiaRecepcion")]
        public async Task<ActionResult<String>> InsertarGuiaRecepcion(GuiaRecepcion recepcion)
        {
            var mensaje = await Task.Run(() => (new GuiaRecepcionDAO()).AgregarGuiaRecepcion(recepcion));
            return Ok(mensaje);
        }

        //actualizar guia recepcion
        [HttpPut("ActualizarGuiaRecepcion")]
        public async Task<ActionResult<String>> ActualizarGuiaRecepcion(GuiaRecepcion recepcion)
        {
            var mensaje = await Task.Run(() => (new GuiaRecepcionDAO()).ActualizarGuiaRecepcion(recepcion));
            return Ok(mensaje);
        }

        //buscar guia de recepcion por ID
        [HttpGet("GetGuiaRecepcionxId/{id}")]
        public async Task<ActionResult<GuiaRecepcion>> GetGuiaRecepcionxId(int id)
        {
            var recepcion = await Task.Run(() => (new GuiaRecepcionDAO()).GetGuiaRecepcionxId(id));
            return Ok(recepcion);
        }

        //Eliminar guia de recepcion
        [HttpDelete("EliminarGuiaRecepcion")]
        public async Task<ActionResult<String>> EliminarGuiaRecepcion(int id)
        {
            var mensaje = await Task.Run(() => (new GuiaRecepcionDAO()).EliminarGuiaRecepcion(id));
            return Ok(mensaje);
        }






    }
}
