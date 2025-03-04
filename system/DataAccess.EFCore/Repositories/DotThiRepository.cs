
using DataAccess.EFCore.AppDbContext;
using DataAccess.EFCore.Repositories.GenericRepo;
using Domain.Entities;
using Domain.Interfaces;

namespace DataAccess.EFCore.Repositories
{
    public class DotThiRepository : GenericRepository<DotThi>, IDotThiRepository
    {
        public DotThiRepository(ApplicationDbContext context) : base(context)
        {
        }
    }
}
