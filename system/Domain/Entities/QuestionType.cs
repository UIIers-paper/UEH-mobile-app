using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class QuestionType
{
    public string Code { get; set; } = null!;

    public string? Desc { get; set; }

    public string? Sample { get; set; }

    public virtual ICollection<Question> Questions { get; set; } = new List<Question>();
}
