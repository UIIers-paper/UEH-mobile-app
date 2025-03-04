using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DeThiController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public DeThiController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var dethis = _unitOfWork.DeThis.GetAll();
            return Ok(dethis);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var deThi = _unitOfWork.DeThis.GetById(id);
            return deThi == null ? NotFound() : Ok(deThi);
        }
    }
}
