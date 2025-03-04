
using DataAccess.EFCore.AppDbContext;
using DataAccess.EFCore.Repositories.GenericRepo;
using Domain.Entities;
using Domain.Interfaces;

namespace DataAccess.EFCore.Repositories
{
    public class ThongTinSinhVienTempRepository : GenericRepository<ThongTinSinhVienTemp>, IThongTinSinhVienTempRepository
    {
        public ThongTinSinhVienTempRepository(ApplicationDbContext context) : base(context)
        {
        }
    }
}
