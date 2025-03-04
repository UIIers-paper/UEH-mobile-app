
using DataAccess.EFCore.AppDbContext;
using DataAccess.EFCore.Repositories.GenericRepo;
using Domain.Entities;
using Domain.Interfaces;

namespace DataAccess.EFCore.Repositories
{
    public class QuestionCategoryRepository : GenericRepository<QuestionCategory>, IQuestionCategoryRepository
    {
        public QuestionCategoryRepository(ApplicationDbContext context) : base(context)
        {
        }
    }
}
