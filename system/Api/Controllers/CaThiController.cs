using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CaThiController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public CaThiController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var cathis = _unitOfWork.CaThis.GetAll();
            return Ok(cathis);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var cathi = _unitOfWork.CaThis.GetById(id);
            return cathi == null ? NotFound() : Ok(cathi);
        }
    }
}
