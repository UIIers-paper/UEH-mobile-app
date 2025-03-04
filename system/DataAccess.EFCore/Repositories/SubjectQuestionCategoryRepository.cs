
using DataAccess.EFCore.AppDbContext;
using DataAccess.EFCore.Repositories.GenericRepo;
using Domain.Entities;
using Domain.Interfaces;

namespace DataAccess.EFCore.Repositories
{
    public class SubjectQuestionCategoryRepository : GenericRepository<SubjectQuestionCategory>, ISubjectQuestionCategoryRepository
    {
        public SubjectQuestionCategoryRepository(ApplicationDbContext context) : base(context)
        {
        }
    }
}
