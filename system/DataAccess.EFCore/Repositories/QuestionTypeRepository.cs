
using DataAccess.EFCore.AppDbContext;
using DataAccess.EFCore.Repositories.GenericRepo;
using Domain.Entities;
using Domain.Interfaces;

namespace DataAccess.EFCore.Repositories
{
    public class QuestionTypeRepository : GenericRepository<QuestionType>, IQuestionTypeRepository
    {
        public QuestionTypeRepository(ApplicationDbContext context) : base(context)
        {
        }
    }
}
