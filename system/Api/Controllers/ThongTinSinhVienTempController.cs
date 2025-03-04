using Domain.Interfaces.IUnitOfWork;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ThongTinSinhVienTempController : ControllerBase
    {
        private readonly IUnitOfWork _unitOfWork;
        public ThongTinSinhVienTempController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }
        [HttpGet]
        public IActionResult GetAll()
        {
            var thongTinSinhVienTemps = _unitOfWork.ThongTinSinhVienTemps.GetAll();
            return Ok(thongTinSinhVienTemps);
        }

        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var thongTinSinhVienTemp = _unitOfWork.ThongTinSinhVienTemps.GetById(id);
            return thongTinSinhVienTemp == null ? NotFound() : Ok(thongTinSinhVienTemp);
        }
    }
}
