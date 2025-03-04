
using DataAccess.EFCore.AppDbContext;
using DataAccess.EFCore.Repositories.GenericRepo;
using Domain.Entities;
using Domain.Interfaces;

namespace DataAccess.EFCore.Repositories
{
    public class NhomDeRepository : GenericRepository<NhomDe>, INhomDeRepository
    {
        public NhomDeRepository(ApplicationDbContext context) : base(context)
        {
        }
    }
}
