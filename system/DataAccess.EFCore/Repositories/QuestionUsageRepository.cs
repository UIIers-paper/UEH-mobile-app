
using DataAccess.EFCore.AppDbContext;
using DataAccess.EFCore.Repositories.GenericRepo;
using Domain.Entities;
using Domain.Interfaces;

namespace DataAccess.EFCore.Repositories
{
    public class QuestionUsageRepository : GenericRepository<QuestionUsage>, IQuestionUsageRepository
    {
        public QuestionUsageRepository(ApplicationDbContext context) : base(context)
        {
        }
    }
}
