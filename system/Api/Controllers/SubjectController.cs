using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SubjectController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public SubjectController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var subjects = _unitOfWork.Subjects.GetAll();
            return Ok(subjects);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var subject = _unitOfWork.Subjects.GetById(id);
            return subject == null ? NotFound() : Ok(subject);
        }
    }
}
