using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QuestionCategoryController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public QuestionCategoryController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var questionCategories = _unitOfWork.QuestionCategories.GetAll();
            return Ok(questionCategories);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var questionCategory = _unitOfWork.QuestionCategories.GetById(id);
            return questionCategory == null ? NotFound() : Ok(questionCategory);
        }
    }
}
