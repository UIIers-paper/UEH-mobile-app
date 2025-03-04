using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class DeThi
{
    public long Id { get; set; }

    public string? Name { get; set; }

    public string? Intro { get; set; }

    public short IntroFormat { get; set; }

    public int TimeLimit { get; set; }

    public short Attempts { get; set; }

    public short ReviewAttempt { get; set; }

    public short ReviewMarks { get; set; }

    public string? MaDe { get; set; }

    public float MaxGrade { get; set; }

    public short DecimalPoints { get; set; }

    public short QuestionNums { get; set; }

    public string? Layout { get; set; }

    public string? Password { get; set; }

    public short HienNutNopBai { get; set; }

    public DateTime CreatedAt { get; set; }

    public int CreatedBy { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public int? ModifiedBy { get; set; }

    public long SubjectId { get; set; }

    public long NhomDeId { get; set; }

    public string? Output { get; set; }

    public virtual ICollection<LuotThi> LuotThis { get; set; } = new List<LuotThi>();

    public virtual NhomDe NhomDe { get; set; } = null!;
}
