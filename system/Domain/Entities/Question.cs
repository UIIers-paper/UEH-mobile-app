using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class Question
{
    public long Id { get; set; }

    public long? Parent { get; set; }

    public string Qtype { get; set; } = null!;

    public string QuestionText { get; set; } = null!;

    public short QuestionTextFormat { get; set; }

    public bool Hidden { get; set; }

    public DateTime CreatedAt { get; set; }

    public int CreatedBy { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public int? ModifiedBy { get; set; }

    public long QuestionCategoryId { get; set; }

    public virtual QuestionType QtypeNavigation { get; set; } = null!;

    public virtual ICollection<QuestionAnswer> QuestionAnswers { get; set; } = new List<QuestionAnswer>();

    public virtual ICollection<QuestionUsage> QuestionUsages { get; set; } = new List<QuestionUsage>();
}
