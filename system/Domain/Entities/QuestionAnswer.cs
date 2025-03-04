using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class QuestionAnswer
{
    public long Id { get; set; }

    public string Answer { get; set; } = null!;

    public short AnswerFormat { get; set; }

    public short Fraction { get; set; }

    public long QuestionId { get; set; }

    public bool IsSwap { get; set; }

    public virtual Question Question { get; set; } = null!;
}
