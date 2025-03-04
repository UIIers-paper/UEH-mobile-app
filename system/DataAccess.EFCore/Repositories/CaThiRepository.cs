
using DataAccess.EFCore.AppDbContext;
using DataAccess.EFCore.Repositories.GenericRepo;
using Domain.Entities;
using Domain.Interfaces;

namespace DataAccess.EFCore.Repositories
{
    public class CaThiRepository : GenericRepository<CaThi>, ICaThiRepository
    {
        public CaThiRepository(ApplicationDbContext context) : base(context)
        {
        }
    }
}
