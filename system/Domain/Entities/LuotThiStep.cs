using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class LuotThiStep
{
    public long Id { get; set; }

    public DateTime CreatedAt { get; set; }

    public long LuotThiId { get; set; }

    public long QuestionUsageId { get; set; }

    public long QuestionAnswerId { get; set; }
}
