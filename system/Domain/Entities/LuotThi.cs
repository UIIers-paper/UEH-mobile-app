using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class LuotThi
{
    public long Id { get; set; }

    public short? Attempt { get; set; }

    public DateTime? StartAt { get; set; }

    public DateTime? FinishAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public decimal? SumGrades { get; set; }

    public string Mssv { get; set; } = null!;

    public long CaThiId { get; set; }

    public long? DeThiId { get; set; }

    public bool LaTsngoai { get; set; }

    public int ExtendTime { get; set; }

    public int Status { get; set; }

    public string? ClientInfo { get; set; }

    public virtual CaThi CaThi { get; set; } = null!;

    public virtual DeThi? DeThi { get; set; }
}
