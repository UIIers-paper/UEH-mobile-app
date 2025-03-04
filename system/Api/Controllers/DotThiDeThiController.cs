using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DotThiDeThiController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public DotThiDeThiController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var dotThiDeThis = _unitOfWork.DotThiDeThis.GetAll();
            return Ok(dotThiDeThis);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var dotThiDeThi = _unitOfWork.DotThiDeThis.GetById(id);
            return dotThiDeThi == null ? NotFound() : Ok(dotThiDeThi);
        }
    }
}
