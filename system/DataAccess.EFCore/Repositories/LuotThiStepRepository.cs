
using DataAccess.EFCore.AppDbContext;
using DataAccess.EFCore.Repositories.GenericRepo;
using Domain.Entities;
using Domain.Interfaces;

namespace DataAccess.EFCore.Repositories
{
    public class LuotThiStepRepository : GenericRepository<LuotThiStep>, ILuotThiStepRepository
    {
        public LuotThiStepRepository(ApplicationDbContext context) : base(context)
        {
        }
    }
}
