using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DotThiController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public DotThiController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var dotThis = _unitOfWork.DotThis.GetAll();
            return Ok(dotThis);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var dotThi = _unitOfWork.DotThis.GetById(id);
            return dotThi == null ? NotFound() : Ok(dotThi);
        }
    }
}
