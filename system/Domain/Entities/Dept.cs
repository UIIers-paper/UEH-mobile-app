using System;
using System.Collections.Generic;

namespace Domain.Entities;

public partial class Dept
{
    public long Id { get; set; }

    public string Code { get; set; } = null!;

    public string Name { get; set; } = null!;

    public string? Desc { get; set; }

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
