using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class DotThi
{
    public long Id { get; set; }

    public string? TenDotThi { get; set; }

    public string? MoTa { get; set; }

    public DateTime NgayBatDau { get; set; }

    public DateTime NgayKetThuc { get; set; }
}
