using Domain.Entities;
using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NhomDeController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public NhomDeController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var nhomDes = _unitOfWork.NhomDes.GetAll();
            return Ok(nhomDes);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var nhomDe = _unitOfWork.NhomDes.GetById(id);
            return nhomDe == null ? NotFound() : Ok(nhomDe);
        }
    }
}
