using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QuestionTypeController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public QuestionTypeController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var questionTypes = _unitOfWork.QuestionTypes.GetAll();
            return Ok(questionTypes);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var questionType = _unitOfWork.CaThis.GetById(id);
            return questionType == null ? NotFound() : Ok(questionType);
        }
    }
}
