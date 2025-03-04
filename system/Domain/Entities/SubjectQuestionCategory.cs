using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class SubjectQuestionCategory
{
    public long Id { get; set; }

    public DateTime CreatedAt { get; set; }

    public int CreatedBy { get; set; }

    public long SubjectId { get; set; }

    public long QuestionCategoryId { get; set; }

    public string? Desc { get; set; }

    public virtual QuestionCategory QuestionCategory { get; set; } = null!;

    public virtual Subject Subject { get; set; } = null!;
}
