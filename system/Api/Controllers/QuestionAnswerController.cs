using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QuestionAnswerController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public QuestionAnswerController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var questionAnswers = _unitOfWork.QuestionAnswers.GetAll();
            return Ok(questionAnswers);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var questionAnswer = _unitOfWork.QuestionAnswers.GetById(id);
            return questionAnswer == null ? NotFound() : Ok(questionAnswer);
        }
    }
}
