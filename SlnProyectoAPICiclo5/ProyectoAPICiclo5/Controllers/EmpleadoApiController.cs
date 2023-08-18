using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ProyectoAPICiclo5.Entidades;
using ProyectoAPICiclo5.DAO;

namespace ProyectoAPICiclo5.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EmpleadoApiController : ControllerBase
    {
        //lista de cargos (para el combo box)
        [HttpGet("GetCargos")]
        public async Task<ActionResult<List<Cargo>>> GetCargos()
        {
            var lista = await Task.Run(() => (new CargoDAO()).GetCargos());
            return Ok(lista);
        }

        //lista de empleados
        [HttpGet("GetEmpleados")]
        public async Task<ActionResult<List<Empleado>>> GetEmpleados()
        {
            var lista = await Task.Run(() => (new EmpleadoDAO()).GetEmpleados());
            return Ok(lista);
        }

        //agregar empleado
        [HttpPost("AgregarEmpleado")]
        public async Task<ActionResult<String>> AgregarEmpleado(Empleado empleado)
        {
            var mensaje = await Task.Run(() => (new EmpleadoDAO()).AgregarEmpleado(empleado));
            return Ok(mensaje);
        }

        //Actualizar Empleado
        [HttpPut("ActualizarEmpleado")]
        public async Task<ActionResult<String>> ActualizarEmpleado(Empleado empleado)
        {
            var mensaje = await Task.Run(() => (new EmpleadoDAO()).ActualizarEmpleado(empleado));
            return Ok(mensaje);
        }

        //buscar empleado por ID
        [HttpGet("GetEmpleadoxId/{id}")]
        public async Task<ActionResult<Empleado>> GetEmpleadoxId(int id)
        {
            var empleado = await Task.Run(() => (new EmpleadoDAO()).GetEmpleadoxId(id));
            return Ok(empleado);
        }

        //eliminar Empleado
        [HttpDelete("EliminarEmpleado")]
        public async Task<ActionResult<String>> EliminarEmpleado(int id)
        {
            var mensaje = await Task.Run(() => (new EmpleadoDAO()).EliminarEmpleado(id));
            return Ok(mensaje);
        }


    }
}
