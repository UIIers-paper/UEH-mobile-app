
using DataAccess.EFCore.AppDbContext;
using DataAccess.EFCore.Repositories.GenericRepo;
using Domain.Entities;
using Domain.Interfaces;

namespace DataAccess.EFCore.Repositories
{
    public class DeThiRepository : GenericRepository<DeThi>, IDeThiRepository
    {
        public DeThiRepository(ApplicationDbContext context) : base(context)
        {
        }
    }
}
