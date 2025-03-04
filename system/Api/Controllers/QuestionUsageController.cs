using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QuestionUsageController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public QuestionUsageController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var questionUsages = _unitOfWork.QuestionUsages.GetAll();
            return Ok(questionUsages);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var questionUsage = _unitOfWork.QuestionUsages.GetById(id);
            return questionUsage == null ? NotFound() : Ok(questionUsage);
        }
    }
}
