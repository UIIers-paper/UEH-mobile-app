using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class ThongTinSinhVien
{
    public string StudentId { get; set; } = null!;

    public string? ClassStudentId { get; set; }

    public string? LastName { get; set; }

    public string? MiddleName { get; set; }

    public string? FirstName { get; set; }

    public string? BirthDay { get; set; }
}
