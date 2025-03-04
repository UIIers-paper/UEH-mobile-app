using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ThongTinSinhVienController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public ThongTinSinhVienController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var thongTinSVs = _unitOfWork.ThongTinSinhViens.GetAll();
            return Ok(thongTinSVs);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(string id)
        {
            var thongTinSv = _unitOfWork.ThongTinSinhViens.Find(o => o.StudentId == id);
            return Ok(thongTinSv);
        }
    }
}
