using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class QuestionUsage
{
    public long Id { get; set; }

    public string AnswerSequence { get; set; } = null!;

    public long QuestionId { get; set; }

    public string? QuestionSummary { get; set; }

    public string? AnswerSummary { get; set; }

    public string? RightAnswer { get; set; }

    public short MaxFraction { get; set; }

    public float MaxMark { get; set; }

    public virtual Question Question { get; set; } = null!;
}
