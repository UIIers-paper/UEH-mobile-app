using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DotThiCanBoThiController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public DotThiCanBoThiController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var dotThiCanBoCoiThis = _unitOfWork.DotThiCanBoCoiThis.GetAll();
            return Ok(dotThiCanBoCoiThis);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var dotThiCanBoCoiThi = _unitOfWork.DotThiCanBoCoiThis.GetById(id);
            return dotThiCanBoCoiThi == null ? NotFound() : Ok(dotThiCanBoCoiThi);
        }
    }
}
