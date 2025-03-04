using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class CaThi
{
    public long Id { get; set; }

    public string? MaCaThi { get; set; }

    public string? TenHienThi { get; set; }

    public string? LopHocPhan { get; set; }

    public string? PhongThi { get; set; }

    public DateTime NgayGioBatDau { get; set; }

    public long SubjectId { get; set; }

    public string? MkgiamThi { get; set; }

    public DateTime? ThucTeBd { get; set; }

    public DateTime? ThucTeKt { get; set; }

    public long NhomDeId { get; set; }

    public virtual ICollection<LuotThi> LuotThis { get; set; } = new List<LuotThi>();

    public virtual NhomDe NhomDe { get; set; } = null!;

    public virtual Subject Subject { get; set; } = null!;
}
