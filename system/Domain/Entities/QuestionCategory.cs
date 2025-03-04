using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class QuestionCategory
{
    public long Id { get; set; }

    public string Name { get; set; } = null!;

    public string? Info { get; set; }

    public short Infoformat { get; set; }

    public long? Parent { get; set; }

    public long SubjectId { get; set; }

    public string FilePath { get; set; } = null!;

    public DateTime? CreatedAt { get; set; }

    public int? CreatedBy { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public int? ModifiedBy { get; set; }

    public string? FileName { get; set; }

    public virtual Subject Subject { get; set; } = null!;

    public virtual ICollection<SubjectQuestionCategory> SubjectQuestionCategories { get; set; } = new List<SubjectQuestionCategory>();
}
