
using DataAccess.EFCore.AppDbContext;
using DataAccess.EFCore.Repositories.GenericRepo;
using Domain.Entities;
using Domain.Interfaces;

namespace DataAccess.EFCore.Repositories
{
    public class DeptRepository : GenericRepository<Dept>, IDeptRepository
    {
        public DeptRepository(ApplicationDbContext context) : base(context)
        {
        }
    }
}
