using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LuotThiController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public LuotThiController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var luotThis = _unitOfWork.LuotThis.GetAll();
            return Ok(luotThis);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var luotThi = _unitOfWork.LuotThis.GetById(id);
            return luotThi == null ? NotFound() : Ok(luotThi);
        }
    }
}
