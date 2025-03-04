using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QuestionController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public QuestionController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var questions = _unitOfWork.Questions.GetAll();
            return Ok(questions);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var question = _unitOfWork.Questions.GetById(id);
            return question == null ? NotFound() : Ok(question);
        }
    }
}
