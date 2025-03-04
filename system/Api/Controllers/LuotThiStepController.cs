using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LuotThiStepController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public LuotThiStepController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var luotThiSteps = _unitOfWork.LuotThiSteps.GetAll();
            return Ok(luotThiSteps);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var luotThiStep = _unitOfWork.LuotThiSteps.GetById(id);
            return luotThiStep == null ? NotFound() : Ok(luotThiStep);
        }
    }
}
