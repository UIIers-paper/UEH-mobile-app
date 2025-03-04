using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class DotThiCanBoCoiThi
{
    public long Id { get; set; }

    public DateTime CreatedAt { get; set; }

    public int CreatedBy { get; set; }

    public long DotThiId { get; set; }

    public long UserId { get; set; }
}
