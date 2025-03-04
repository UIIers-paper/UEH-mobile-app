using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class Subject
{
    public long Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Desc { get; set; }

    public int UserId { get; set; }

    public DateTime CreatedAt { get; set; }

    public int CreatedBy { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public int? ModifiedBy { get; set; }

    public virtual ICollection<CaThi> CaThis { get; set; } = new List<CaThi>();

    public virtual User CreatedByNavigation { get; set; } = null!;

    public virtual ICollection<NhomDe> NhomDes { get; set; } = new List<NhomDe>();

    public virtual ICollection<QuestionCategory> QuestionCategories { get; set; } = new List<QuestionCategory>();

    public virtual ICollection<SubjectQuestionCategory> SubjectQuestionCategories { get; set; } = new List<SubjectQuestionCategory>();

    public virtual User User { get; set; } = null!;
}
