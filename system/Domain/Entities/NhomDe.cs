using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class NhomDe
{
    public long Id { get; set; }

    public string? TenNhomDe { get; set; }

    public DateTime CreatedAt { get; set; }

    public int CreatedBy { get; set; }

    public long SubjectId { get; set; }

    public int ChoXemDiem { get; set; }

    public string? CauTrucDeThi { get; set; }

    public int HienNutNopBai { get; set; }

    public string? GhiChuGv { get; set; }

    public string? KieuDe { get; set; }

    public float DiemToiDa { get; set; }

    public int SoLanThiChoPhep { get; set; }

    public int Slde { get; set; }

    public int ThoiGianThi { get; set; }

    public int TongSlcauHoi { get; set; }

    public virtual ICollection<CaThi> CaThis { get; set; } = new List<CaThi>();

    public virtual ICollection<DeThi> DeThis { get; set; } = new List<DeThi>();

    public virtual Subject Subject { get; set; } = null!;
}
