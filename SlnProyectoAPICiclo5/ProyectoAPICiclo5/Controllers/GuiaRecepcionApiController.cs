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

        [HttpGet("GetGuiasRecepcion")]
        public async Task<ActionResult<List<GuiaRecepcion>>> GetGuiaRecepcion()
        {
            var lista = await Task.Run(() => (new GuiaRecepcionDAO()).GetGuiasRecepcion());
            return Ok(lista);
        }






    }
}
