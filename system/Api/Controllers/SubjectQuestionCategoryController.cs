using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SubjectQuestionCategoryController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public SubjectQuestionCategoryController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var subjectQuestionCategories = _unitOfWork.SubjectQuestionCategories.GetAll();
            return Ok(subjectQuestionCategories);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var subjectQuestionCategory = _unitOfWork.SubjectQuestionCategories.GetById(id);
            return subjectQuestionCategory == null ? NotFound() : Ok(subjectQuestionCategory);
        }
    }
}
