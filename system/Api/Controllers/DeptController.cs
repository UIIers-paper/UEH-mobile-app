using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DeptController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public DeptController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var cathis = _unitOfWork.Depts.GetAll();
            return Ok(cathis);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var depts = _unitOfWork.Depts.GetById(id);
            return depts == null ? NotFound() : Ok(depts);
        }
    }
}
