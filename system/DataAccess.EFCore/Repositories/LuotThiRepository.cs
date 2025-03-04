
using DataAccess.EFCore.AppDbContext;
using DataAccess.EFCore.Repositories.GenericRepo;
using Domain.Entities;
using Domain.Interfaces;

namespace DataAccess.EFCore.Repositories
{
    public class LuotThiRepository : GenericRepository<LuotThi>, ILuotThiRepository
    {
        public LuotThiRepository(ApplicationDbContext context) : base(context)
        {
        }
    }
}
