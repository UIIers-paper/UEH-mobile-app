
using DataAccess.EFCore.AppDbContext;
using Domain.Interfaces;
using Domain.Interfaces.IUnitOfWork;

namespace DataAccess.EFCore.Repositories.UnitOfWorkRepo
{
    public class UnitOfWork : IUnitOfWork
    {
        private readonly ApplicationDbContext _context;
        public ICaThiRepository CaThis { get; private set; }
        public IThongTinSinhVienRepository ThongTinSinhViens { get; private set; }

        public IDeptRepository Depts { get; private set; }

        public IDeThiRepository DeThis { get; private set; }

        public IDotThiCanBoCoiThi DotThiCanBoCoiThis { get; private set; }

        public IDotThiDeThiRepository DotThiDeThis { get; private set; }

        public IDotThiRepository DotThis { get; private set; }

        public ILuotThiRepository LuotThis { get; private set; }

        public ILuotThiStepRepository LuotThiSteps { get; private set; }

        public INhomDeRepository NhomDes { get; private set; }

        public IQuestionAnswerRepository QuestionAnswers { get; private set; }

        public IQuestionCategoryRepository QuestionCategories { get; private set; }

        public IQuestionRepository Questions { get; private set; }

        public IQuestionTypeRepository QuestionTypes { get; private set; }

        public IQuestionUsageRepository QuestionUsages { get; private set; }

        public ISubjectQuestionCategoryRepository SubjectQuestionCategories { get; private set; }

        public ISubjectRepository Subjects { get; private set; }

        public IThongTinSinhVienTempRepository ThongTinSinhVienTemps { get; private set; }

        public IUserRepository Users { get; private set; }

        public UnitOfWork(ApplicationDbContext context)
        {
            _context = context;
            CaThis = new CaThiRepository(_context);
            Depts = new DeptRepository(_context);
            DeThis = new DeThiRepository(_context);
            DotThiCanBoCoiThis = new DotThiCanBoCoiThiRepository(_context);
            DotThiDeThis = new DotThiDeThiRepository(_context);
            DotThis = new DotThiRepository(_context);
            LuotThis = new LuotThiRepository(_context);
            LuotThiSteps = new LuotThiStepRepository(_context);
            NhomDes = new NhomDeRepository(_context);
            QuestionAnswers = new QuestionAnswerRepository(_context);
            QuestionCategories = new QuestionCategoryRepository(_context);
            Questions = new QuestionRepository(_context);
            QuestionTypes = new QuestionTypeRepository(_context);
            QuestionUsages = new QuestionUsageRepository(_context);
            SubjectQuestionCategories = new SubjectQuestionCategoryRepository(_context);
            Subjects = new SubjectRepository(_context);
            ThongTinSinhViens = new ThongTinSinhVienReporitory(_context);
            ThongTinSinhVienTemps = new ThongTinSinhVienTempRepository(_context);
            Users = new UserRepository(_context);
        }

        public int Complete()
        {
            return _context.SaveChanges();
        }

        public void Dispose()
        {
            _context.Dispose();
        }
    }
}
