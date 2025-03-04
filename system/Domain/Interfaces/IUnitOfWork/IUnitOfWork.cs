using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Interfaces.IUnitOfWork
{
    public interface IUnitOfWork : IDisposable
    {
        ICaThiRepository CaThis { get; }
        IDeptRepository Depts { get; }
        IDeThiRepository DeThis { get; }
        IDotThiCanBoCoiThi DotThiCanBoCoiThis { get; }
        IDotThiDeThiRepository DotThiDeThis { get; }
        IDotThiRepository DotThis { get; }
        ILuotThiRepository LuotThis { get; }
        ILuotThiStepRepository LuotThiSteps { get; }
        INhomDeRepository NhomDes { get; }
        IQuestionAnswerRepository QuestionAnswers { get; }
        IQuestionCategoryRepository QuestionCategories { get; }
        IQuestionRepository Questions { get; }
        IQuestionTypeRepository QuestionTypes { get; }
        IQuestionUsageRepository QuestionUsages { get; }
        ISubjectQuestionCategoryRepository SubjectQuestionCategories { get; }
        ISubjectRepository Subjects { get; }
        IThongTinSinhVienRepository ThongTinSinhViens { get; }
        IThongTinSinhVienTempRepository ThongTinSinhVienTemps { get; }
        IUserRepository Users { get; }
        int Complete();
    }
}
