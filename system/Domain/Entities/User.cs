using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class User
{
    public int Id { get; set; }

    public string Username { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string Fullname { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string Phone1 { get; set; } = null!;

    public string? Phone2 { get; set; }

    public bool Suspended { get; set; }

    public bool Deleted { get; set; }

    public DateTime CreatedAt { get; set; }

    public DateTime? ModifiedAt { get; set; }

    public long DepartmentId { get; set; }

    public virtual Dept Department { get; set; } = null!;

    public virtual ICollection<Subject> SubjectCreatedByNavigations { get; set; } = new List<Subject>();

    public virtual ICollection<Subject> SubjectUsers { get; set; } = new List<Subject>();
}
